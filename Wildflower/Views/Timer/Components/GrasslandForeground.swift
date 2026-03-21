import SwiftUI

struct GrasslandForeground: View {
    @State private var swayOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                // Grass strip
                Image("timer_grass_fg")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width + 20, height: geo.size.height * 0.14)
                    .offset(x: swayOffset)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

                // Fence on the left
                Image("timer_fence")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 80, height: 60)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .offset(x: 16, y: -geo.size.height * 0.10)

                // Bush on the right
                Image("timer_bush_berry")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .offset(x: -20, y: -geo.size.height * 0.09)
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 6)
                .repeatForever(autoreverses: true)
            ) {
                swayOffset = 4
            }
        }
        .allowsHitTesting(false)
    }
}
