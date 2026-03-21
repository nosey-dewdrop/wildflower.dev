import SwiftUI

struct SceneTrees: View {
    @State private var leftSway: CGFloat = 0
    @State private var rightSway: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Left oak tree - anchored to grass line
                Image("timer_tree_oak")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .rotationEffect(.degrees(leftSway), anchor: .bottom)
                    .position(
                        x: 44,
                        y: geo.size.height * 0.72
                    )

                // Right pine tree - anchored to grass line
                Image("timer_tree_pine")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 70, height: 150)
                    .rotationEffect(.degrees(rightSway), anchor: .bottom)
                    .position(
                        x: geo.size.width - 30,
                        y: geo.size.height * 0.70
                    )
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 4)
                .repeatForever(autoreverses: true)
            ) {
                leftSway = 1.5
            }
            withAnimation(
                .easeInOut(duration: 3.5)
                .repeatForever(autoreverses: true)
            ) {
                rightSway = -1.2
            }
        }
        .allowsHitTesting(false)
    }
}
