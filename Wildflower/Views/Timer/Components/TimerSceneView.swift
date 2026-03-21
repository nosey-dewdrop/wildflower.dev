import SwiftUI

struct TimerSceneView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Layer 0: Sky gradient
                LinearGradient(
                    colors: [
                        Color(hex: "87CEEB"),
                        Color(hex: "B4D8E7"),
                        Color(hex: "E8D5B7")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Layer 1: Sun (center-right, clear of UI)
                GentleSun()
                    .position(
                        x: geo.size.width * 0.75,
                        y: geo.size.height * 0.08
                    )

                // Layer 2: Clouds at different heights
                DriftingCloud(
                    imageName: "timer_cloud_a",
                    width: 120, height: 60,
                    yPercent: 0.06,
                    duration: 50,
                    startDelay: 0
                )
                DriftingCloud(
                    imageName: "timer_cloud_b",
                    width: 140, height: 46,
                    yPercent: 0.18,
                    duration: 60,
                    startDelay: 5
                )
                DriftingCloud(
                    imageName: "timer_cloud_c",
                    width: 160, height: 64,
                    yPercent: 0.12,
                    duration: 42,
                    startDelay: 12
                )

                // Layer 3: Far hills
                ParallaxHills()

                // Layer 5: Trees
                SceneTrees()

                // Layer 6: Grass foreground
                GrasslandForeground()

                // Layer 7: Butterflies
                FloatingButterfly(imageName: "timer_butterfly_a", size: 28)
                    .position(
                        x: geo.size.width * 0.25,
                        y: geo.size.height * 0.50
                    )

                FloatingButterfly(imageName: "timer_butterfly_b", size: 24)
                    .position(
                        x: geo.size.width * 0.72,
                        y: geo.size.height * 0.45
                    )
            }
        }
        .ignoresSafeArea()
    }
}
