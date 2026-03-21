import SwiftUI

// Fence layer - goes IN FRONT of trees
struct FenceForeground: View {
    let groundY: CGFloat

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            ZStack {
                // Left pair
                Image("timer_fence")
                    .resizable().interpolation(.none).scaledToFit()
                    .frame(width: 110, height: 75)
                    .position(x: 25, y: groundY + 20)

                Image("timer_fence")
                    .resizable().interpolation(.none).scaledToFit()
                    .frame(width: 110, height: 75)
                    .position(x: 115, y: groundY + 20)

                // Right pair
                Image("timer_fence")
                    .resizable().interpolation(.none).scaledToFit()
                    .frame(width: 110, height: 75)
                    .position(x: w - 115, y: groundY + 20)

                Image("timer_fence")
                    .resizable().interpolation(.none).scaledToFit()
                    .frame(width: 110, height: 75)
                    .position(x: w - 25, y: groundY + 20)
            }
        }
        .allowsHitTesting(false)
    }
}
