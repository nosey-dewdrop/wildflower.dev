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
            // pixel art background - grass, sky, clouds, bushes
            Image("timer_bg")
                .resizable()
                .interpolation(.none)
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // top bar
                HStack {
                    CoinDisplay(amount: coinsEarned)
                    Spacer()
                    Button {
                        showAddGoal = true
                    } label: {
                        Text("+")
                            .font(.pixel(14))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 0, x: 1, y: 1)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer()

                // flower growing on the grass
                VStack(spacing: 0) {
                    Image(flowerStages[stageForTime])
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .animation(.spring(response: 0.6), value: stageForTime)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                }
                .padding(.bottom, 40)

                // timer display
                Text(formattedTime)
                    .font(.pixel(28))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 0, x: 2, y: 2)
                    .padding(.bottom, 20)

                // progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black.opacity(0.3))
                            .frame(height: 12)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(hex: "4A7C59"))
                            .frame(width: geo.size.width * min(CGFloat(timeElapsed) / 1800.0, 1.0), height: 12)
                            .animation(.easeInOut(duration: 0.5), value: timeElapsed)
                    }
                }
                .frame(height: 12)
                .padding(.horizontal, 40)

                Spacer().frame(height: 24)

                // goal selection
                if !goals.isEmpty && selectedGoal == nil && !isRunning {
                    VStack(spacing: 8) {
                        Text("pick a goal")
                            .font(.pixel(7))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.6), radius: 0, x: 1, y: 1)
                            .padding(.top, 4)

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
                                                .font(.pixel(6))
                                                .foregroundColor(.white)
                                                .padding(.top, 2)
                                        }
                                        .padding(12)
                                        .background(Color.black.opacity(0.4))
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
                                .font(.pixel(7))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.6), radius: 0, x: 1, y: 1)
                                .padding(.top, 4)
                            Text("tap + to create one")
                                .font(.pixel(6))
                                .foregroundColor(.white.opacity(0.7))
                                .shadow(color: .black.opacity(0.6), radius: 0, x: 1, y: 1)
                                .padding(.top, 2)
                        }
                    }
                }

                if let goal = selectedGoal, !isRunning {
                    HStack(spacing: 6) {
                        Text(goal.emoji)
                            .font(.system(size: 16))
                        Text(goal.name)
                            .font(.pixel(7))
                            .foregroundColor(.white)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }

                Spacer().frame(height: 16)

                // start/stop button
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

                Spacer().frame(height: 16)
            }
            .padding()
        }
        .sheet(isPresented: $showAddGoal) {
            AddGoalView()
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
