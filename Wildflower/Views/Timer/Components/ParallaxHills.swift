import SwiftUI

struct ParallaxHills: View {
    @State private var farOffset: CGFloat = 0
    @State private var nearOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                // Far hills - subtle sway
                Image("timer_hills_far")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width + 40, height: geo.size.height * 0.18)
                    .offset(x: farOffset)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .offset(y: -geo.size.height * 0.22)

                // Near hills - slightly more sway
                Image("timer_hills_near")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width + 30, height: geo.size.height * 0.20)
                    .offset(x: nearOffset)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .offset(y: -geo.size.height * 0.10)
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 12)
                .repeatForever(autoreverses: true)
            ) {
                farOffset = 8
            }
            withAnimation(
                .easeInOut(duration: 8)
                .repeatForever(autoreverses: true)
            ) {
                nearOffset = -6
            }
        }
        .allowsHitTesting(false)
    }
}
