import SwiftUI

struct GentleSun: View {
    @State private var glowPulse = false
    @State private var rayRotation: Double = 0

    var body: some View {
        ZStack {
            // Outer warm glow (pixel-friendly soft aura)
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "FFF4B8").opacity(0.5),
                            Color(hex: "FFE566").opacity(0.2),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 20,
                        endRadius: glowPulse ? 80 : 65
                    )
                )
                .frame(width: 160, height: 160)

            // Pixel art sun sprite
            Image("timer_sun_pixel")
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 72, height: 72)
                .rotationEffect(.degrees(rayRotation))
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3)
                .repeatForever(autoreverses: true)
            ) {
                glowPulse = true
            }
            withAnimation(
                .linear(duration: 60)
                .repeatForever(autoreverses: false)
            ) {
                rayRotation = 360
            }
        }
    }
}
