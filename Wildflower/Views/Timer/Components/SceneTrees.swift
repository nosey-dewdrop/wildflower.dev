import SwiftUI

struct SceneTrees: View {
    let groundY: CGFloat

    @State private var leftSway: CGFloat = 0
    @State private var rightSway: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width

            ZStack {
                // Left oak tree - full size
                Image("timer_tree_oak")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 170, height: 240)
                    .rotationEffect(.degrees(leftSway), anchor: .bottom)
                    .position(x: 70, y: groundY - 105)

                // Right pine tree - full size
                Image("timer_tree_pine")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 120, height: 240)
                    .rotationEffect(.degrees(rightSway), anchor: .bottom)
                    .position(x: w - 50, y: groundY - 105)


            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                leftSway = 1.5
            }
            withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
                rightSway = -1.2
            }
        }
        .allowsHitTesting(false)
    }
}
