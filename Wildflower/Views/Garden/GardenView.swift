import SwiftUI
import SwiftData

struct GardenView: View {
    @Query private var goals: [Goal]

    var body: some View {
        ZStack {
            Color(hex: "2D5A27").ignoresSafeArea()

            VStack {
                Text("My Garden")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top)

                if goals.isEmpty {
                    Spacer()
                    VStack(spacing: 16) {
                        Image("daisy_1_seed")
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .opacity(0.6)

                        Text("Start a focus session\nto grow your first flower")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.7))
                            .font(.subheadline)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
                            ForEach(goals) { goal in
                                GardenFlowerCell(goal: goal)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct GardenFlowerCell: View {
    let goal: Goal

    private var stageImage: String {
        let totalMinutes = goal.totalSeconds / 60
        switch totalMinutes {
        case 0..<1: return "daisy_1_seed"
        case 1..<5: return "daisy_2_sprout"
        case 5..<15: return "daisy_3_bud"
        case 15..<30: return "daisy_4_blooming"
        default: return "daisy_5_full_bloom"
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            Image(stageImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 64, height: 64)

            Text(goal.emoji)
                .font(.title3)
            Text(goal.name)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.8))
            Text(goal.totalFormattedTime)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    GardenView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
