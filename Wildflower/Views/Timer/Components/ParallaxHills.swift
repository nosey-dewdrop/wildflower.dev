import SwiftUI

struct ParallaxHills: View {
    let groundY: CGFloat

    @State private var farOffset: CGFloat = 0
    @State private var nearOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Far hills - sits behind the ground, creates natural horizon
                Image("timer_hills_far")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width + 60, height: geo.size.height * 0.22)
                    .offset(x: farOffset)
                    .position(
                        x: geo.size.width / 2,
                        y: groundY - geo.size.height * 0.06
                    )

                // Near hills - overlaps ground line for smooth transition
                Image("timer_hills_near")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width + 40, height: geo.size.height * 0.18)
                    .offset(x: nearOffset)
                    .position(
                        x: geo.size.width / 2,
                        y: groundY + geo.size.height * 0.02
                    )
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
