import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]

    @State private var selectedGoal: Goal?
    @State private var timeElapsed: Int = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var currentStage = 0

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
            Color(hex: "1A1A2E").ignoresSafeArea()

            VStack(spacing: 24) {
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("\(coinsEarned)")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(hex: "FFD700"))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(hex: "2A2A4A").opacity(0.8))
                .cornerRadius(20)

                Spacer()

                ZStack {
                    Circle()
                        .stroke(Color(hex: "4A7C59").opacity(0.3), lineWidth: 8)
                        .frame(width: 260, height: 260)

                    Circle()
                        .trim(from: 0, to: min(CGFloat(timeElapsed) / 1800.0, 1.0))
                        .stroke(Color(hex: "4A7C59"), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 260, height: 260)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.5), value: timeElapsed)

                    VStack(spacing: 12) {
                        Image(flowerStages[stageForTime])
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .animation(.spring(response: 0.6), value: stageForTime)

                        Text(formattedTime)
                            .font(.system(size: 48, weight: .thin, design: .monospaced))
                            .foregroundColor(.white)
                    }
                }

                Spacer()

                if !goals.isEmpty && selectedGoal == nil {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(goals) { goal in
                                Button {
                                    selectedGoal = goal
                                } label: {
                                    VStack(spacing: 4) {
                                        Text(goal.emoji)
                                            .font(.title2)
                                        Text(goal.name)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(goal.color.opacity(0.3))
                                    .cornerRadius(16)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                if let goal = selectedGoal {
                    HStack(spacing: 6) {
                        Text(goal.emoji)
                        Text(goal.name)
                            .foregroundColor(.white.opacity(0.8))
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(goal.color.opacity(0.2))
                    .cornerRadius(12)
                }

                Button {
                    if isRunning {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                } label: {
                    Text(isRunning ? "Stop" : "Start Growing")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(width: 200, height: 56)
                        .background(isRunning ? Color(hex: "C0392B") : Color(hex: "4A7C59"))
                        .cornerRadius(28)
                }
                .padding(.bottom, 20)
            }
            .padding()
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
    }
}

#Preview {
    TimerView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
