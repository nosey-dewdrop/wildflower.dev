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
            // Living scene background
            TimerSceneView()

            VStack(spacing: 0) {
                HStack {
                    CoinDisplay(amount: coinsEarned)
                    Spacer()
                    Button {
                        showAddGoal = true
                    } label: {
                        Text("+")
                            .font(.pixelBold(22))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                Spacer()

                Text(formattedTime)
                    .font(.pixelBold(52))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 2, y: 2)

                Spacer()

                ZStack(alignment: .bottom) {
                    Image("timer_soil_plot")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 90, height: 45)

                    Image(flowerStages[stageForTime])
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .offset(y: -30)
                        .animation(.spring(response: 0.6), value: stageForTime)
                }

                if !goals.isEmpty && selectedGoal == nil && !isRunning {
                    VStack(spacing: 8) {
                        Text("pick a goal")
                            .font(.pixel(13))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(goals) { goal in
                                    Button {
                                        selectedGoal = goal
                                    } label: {
                                        VStack(spacing: 6) {
                                            Text(goal.emoji)
                                                .font(.system(size: 22))
                                            Text(goal.name)
                                                .font(.pixel(10))
                                                .foregroundColor(.white)
                                        }
                                        .padding(10)
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
                        VStack(spacing: 6) {
                            Text("no goals yet")
                                .font(.pixel(13))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                            Text("tap + to create one")
                                .font(.pixel(10))
                                .foregroundColor(.white.opacity(0.7))
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                        }
                    }
                }

                if let goal = selectedGoal, !isRunning {
                    HStack(spacing: 6) {
                        Text(goal.emoji)
                            .font(.system(size: 16))
                        Text(goal.name)
                            .font(.pixel(12))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                }

                if isRunning {
                    PixelButton("Stop", isDestructive: true) {
                        stopTimer()
                    }
                    .frame(width: 180)
                } else {
                    PixelButton("Start") {
                        startTimer()
                    }
                    .frame(width: 180)
                }

                Spacer().frame(height: 12)
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
