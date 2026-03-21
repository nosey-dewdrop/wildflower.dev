import SwiftUI

struct GentleSun: View {
    @State private var glowPulse = false
    @State private var rayRotation: Double = 0

    var body: some View {
        ZStack {
            // Outer warm glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "FFF4B8").opacity(0.4),
                            Color(hex: "FFE566").opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: glowPulse ? 55 : 45
                    )
                )
                .frame(width: 110, height: 110)

            // Inner bright core
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(hex: "FFFDE0"),
                            Color(hex: "FFE566"),
                            Color(hex: "FFD036")
                        ],
                        center: .center,
                        startRadius: 2,
                        endRadius: 18
                    )
                )
                .frame(width: 36, height: 36)

            // Subtle ray lines
            ForEach(0..<8, id: \.self) { i in
                Capsule()
                    .fill(Color(hex: "FFE566").opacity(0.3))
                    .frame(width: 2, height: 12)
                    .offset(y: -28)
                    .rotationEffect(.degrees(Double(i) * 45 + rayRotation))
            }
        }
        .onAppear {
            withAnimation(
                .easeInOut(duration: 3)
                .repeatForever(autoreverses: true)
            ) {
                glowPulse = true
            }
            withAnimation(
                .linear(duration: 30)
                .repeatForever(autoreverses: false)
            ) {
                rayRotation = 360
            }
        }
    }
}
