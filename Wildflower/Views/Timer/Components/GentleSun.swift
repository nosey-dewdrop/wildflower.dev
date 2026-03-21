import SwiftUI

struct GentleSun: View {
    @State private var glowPulse = false

    var body: some View {
        ZStack {
            // Soft warm glow behind pixel sun
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "FFF8DC").opacity(0.5),
                            Color(hex: "FFE566").opacity(0.2),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 50,
                        endRadius: glowPulse ? 110 : 95
                    )
                )
                .frame(width: 220, height: 220)

            // Pixel art sun sprite - BIG
            Image("timer_sun_warm")
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 130, height: 130)
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3.5)
                .repeatForever(autoreverses: true)
            ) {
                glowPulse = true
            }
        }
    }
}
