import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]

    @State private var selectedGoal: Goal?
    @State private var timeElapsed: Int = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var showAddGoal = false
    @State private var cloudOffset1: CGFloat = 0
    @State private var cloudOffset2: CGFloat = 200

    private let flowerStages = [
        "daisy_1_seed",
        "daisy_2_sprout",
        "daisy_3_bud",
        "daisy_4_blooming",
        "daisy_5_full_bloom"
    ]

    private var stageForTime: Int {
        switch timeElapsed {
        case 0..<60: return 0
        case 60..<300: return 1
        case 300..<900: return 2
        case 900..<1800: return 3
        default: return 4
        }
    }

    private var coinsEarned: Int {
        timeElapsed / 60
    }

    private var formattedTime: String {
        let minutes = timeElapsed / 60
        let seconds = timeElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        ZStack {
            // Sky background
            Image("timer_sky")
                .resizable()
                .interpolation(.none)
                .scaledToFill()
                .ignoresSafeArea()

            // Animated clouds
            GeometryReader { geo in
                Image("cloud_1")
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 128, height: 64)
                    .offset(x: cloudOffset1, y: 60)

                Image("cloud_2")
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 160, height: 80)
                    .offset(x: cloudOffset2, y: 120)
            }

            // Grass ground at bottom
            VStack {
                Spacer()
                Image("timer_grass")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
            }
            .ignoresSafeArea(edges: .bottom)

            // Main content
            VStack(spacing: 16) {
                // Top bar with coin display
                HStack {
                    CoinDisplay(amount: coinsEarned)
                    Spacer()
                    Button {
                        showAddGoal = true
                    } label: {
                        Text("+")
                            .font(.pixelBold(20))
                            .foregroundColor(Color(hex: "4A7C59"))
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Timer display
                Text(formattedTime)
                    .font(.pixelBold(32))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    .pixelText()

                Spacer()

                // Flower growing on soil
                ZStack {
                    Image("soil_mound")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 128, height: 96)

                    Image(flowerStages[stageForTime])
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .offset(y: -40)
                        .animation(.spring(response: 0.6), value: stageForTime)
                }
                .padding(.bottom, 40)

                // Goal selection
                if !goals.isEmpty && selectedGoal == nil && !isRunning {
                    VStack(spacing: 8) {
                        Text("pick a goal")
                            .font(.pixel(12))
                            .foregroundColor(.white.opacity(0.7))
                            .shadow(color: .black.opacity(0.5), radius: 0, x: 1, y: 1)
                            .pixelText()

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(goals) { goal in
                                    Button {
                                        selectedGoal = goal
                                    } label: {
                                        VStack(spacing: 6) {
                                            Text(goal.emoji)
                                                .font(.system(size: 24))
                                            Text(goal.name)
                                                .font(.pixel(10))
                                                .foregroundColor(.white)
                                                .pixelText()
                                        }
                                        .padding(12)
                                        .background(goal.color.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else if goals.isEmpty && !isRunning {
                    Button {
                        showAddGoal = true
                    } label: {
                        VStack(spacing: 8) {
                            Text("no goals yet")
                                .font(.pixel(12))
                                .foregroundColor(.white.opacity(0.7))
                                .shadow(color: .black.opacity(0.5), radius: 0, x: 1, y: 1)
                                .pixelText()
                            Text("tap + to create one")
                                .font(.pixel(10))
                                .foregroundColor(.white.opacity(0.5))
                                .shadow(color: .black.opacity(0.5), radius: 0, x: 1, y: 1)
                                .pixelText()
                        }
                    }
                }

                if let goal = selectedGoal, !isRunning {
                    HStack(spacing: 6) {
                        Text(goal.emoji)
                            .font(.system(size: 16))
                        Text(goal.name)
                            .font(.pixel(12))
                            .foregroundColor(.white.opacity(0.8))
                            .pixelText()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(goal.color.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }

                if isRunning {
                    PixelButton("Stop", isDestructive: true) {
                        stopTimer()
                    }
                    .frame(width: 200)
                } else {
                    PixelButton("Start Growing") {
                        startTimer()
                    }
                    .frame(width: 200)
                }

                Spacer().frame(height: 8)
            }
            .padding()
        }
        .sheet(isPresented: $showAddGoal) {
            AddGoalView()
        }
        .onAppear {
            startCloudAnimation()
        }
    }

    private func startCloudAnimation() {
        withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
            cloudOffset1 = UIScreen.main.bounds.width + 150
        }
        withAnimation(.linear(duration: 30).repeatForever(autoreverses: false)) {
            cloudOffset2 = UIScreen.main.bounds.width + 200
        }
    }

    private func startTimer() {
        if selectedGoal == nil && !goals.isEmpty {
            return
        }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil

        if let goal = selectedGoal, timeElapsed > 0 {
            let session = Session(goal: goal, duration: timeElapsed)
            modelContext.insert(session)
        }

        timeElapsed = 0
        selectedGoal = nil
    }
}

#Preview {
    TimerView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
