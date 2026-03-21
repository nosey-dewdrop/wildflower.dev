import SwiftUI

struct TimerSceneView: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let groundY = h * 0.62

            ZStack {
                // Sky gradient
                LinearGradient(
                    colors: [
                        Color(hex: "87CEEB"),
                        Color(hex: "B4D8E7"),
                        Color(hex: "D4E4D0")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Sun
                GentleSun()
                    .position(x: w * 0.80, y: h * 0.10)

                // Clouds
                DriftingCloud(imageName: "timer_cloud_soft_a", width: 300, y: h * 0.10, startX: -180, endX: 160, duration: 28)
                DriftingCloud(imageName: "timer_cloud_soft_d", width: 260, y: h * 0.22, startX: 160, endX: -180, duration: 36)
                DriftingCloud(imageName: "timer_cloud_soft_c", width: 200, y: h * 0.06, startX: -80, endX: 120, duration: 22)
                DriftingCloud(imageName: "timer_cloud_soft_a", width: 280, y: h * 0.30, startX: 200, endX: -160, duration: 40)
                DriftingCloud(imageName: "timer_cloud_soft_d", width: 220, y: h * 0.16, startX: -220, endX: 200, duration: 32)

                // Hills
                ParallaxHills(groundY: groundY)

                // Ground fill
                Rectangle()
                    .fill(Color(red: 0.35, green: 0.56, blue: 0.24))
                    .frame(width: w + 20, height: h - groundY + 20)
                    .position(x: w / 2, y: groundY + (h - groundY) / 2)

                // Ground texture overlay (tiled)
                GroundTextureOverlay(groundY: groundY)

                // Trees and fence
                SceneTrees(groundY: groundY)
                FenceForeground(groundY: groundY)

                // Butterflies
                FloatingButterfly(imageName: "timer_butterfly_a", size: 30)
                    .position(x: w * 0.35, y: groundY - h * 0.08)
                FloatingButterfly(imageName: "timer_butterfly_b", size: 26)
                    .position(x: w * 0.65, y: groundY - h * 0.14)
            }
        }
        .ignoresSafeArea()
    }
}
