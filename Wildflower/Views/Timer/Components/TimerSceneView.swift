import SwiftUI

struct TimerSceneView: View {
    // Position element so its BOTTOM sits at bottomY
    // .position() uses center, so: centerY = bottomY - height/2
    private func bottomAt(_ bottomY: CGFloat, height: CGFloat) -> CGFloat {
        bottomY - height / 2
    }

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            // Ground line: where the TOP of the grass is
            let groundY = h * 0.62

            ZStack {
                // ========== LAYER 0: SKY ==========
                // Normal daytime blue sky
                LinearGradient(
                    colors: [
                        Color(hex: "4A90D9"),
                        Color(hex: "7EC8E3"),
                        Color(hex: "A8DCF0")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // ========== LAYER 1: SUN ==========
                GentleSun()
                    .position(x: w * 0.73, y: h * 0.10)

                // ========== LAYER 2: CLOUDS ==========
                // Spread across the sky, big and fluffy
                DriftingCloud(
                    imageName: "timer_cloud_a",
                    width: 240, height: 120,
                    x: w * 0.25, y: h * 0.09,
                    driftAmount: 50,
                    duration: 45
                )
                DriftingCloud(
                    imageName: "timer_cloud_b",
                    width: 200, height: 80,
                    x: w * 0.65, y: h * 0.20,
                    driftAmount: -40,
                    duration: 55
                )
                DriftingCloud(
                    imageName: "timer_cloud_c",
                    width: 280, height: 112,
                    x: w * 0.40, y: h * 0.14,
                    driftAmount: 35,
                    duration: 38
                )

                // ========== LAYER 3: FAR HILLS ==========
                // Bottom overlaps with near hills
                Image("timer_hills_far")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: w + 40, height: 140)
                    .clipped()
                    .position(
                        x: w / 2,
                        y: bottomAt(groundY + 30, height: 140)
                    )

                // ========== LAYER 4: NEAR HILLS ==========
                // Bottom overlaps with grass top
                Image("timer_hills_near")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: w + 30, height: 180)
                    .clipped()
                    .position(
                        x: w / 2,
                        y: bottomAt(groundY + 60, height: 180)
                    )

                // ========== LAYER 5: TREES ==========
                // Big, bases embedded in grass (bottom below groundY)

                // Oak tree - left-center, BEHIND where flower will be
                Image("timer_tree_oak")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 300)
                    .position(
                        x: w * 0.25,
                        y: bottomAt(groundY + 40, height: 300)
                    )

                // Pine tree - right side
                Image("timer_tree_pine")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 140, height: 280)
                    .position(
                        x: w * 0.82,
                        y: bottomAt(groundY + 40, height: 280)
                    )

                // ========== LAYER 6: GRASS FOREGROUND ==========
                // Thick lush grass, top at groundY, extends down past screen
                Image("timer_grass_fg")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: w + 20, height: 240)
                    .clipped()
                    .position(
                        x: w / 2,
                        y: groundY + 120
                    )

                // ========== LAYER 7: GROUND DECORATIONS ==========
                // All sitting IN the grass, same ground line

                // Fence - left side, embedded in grass
                Image("timer_fence")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 100, height: 75)
                    .position(
                        x: 65,
                        y: bottomAt(groundY + 50, height: 75)
                    )

                // Bush - right side, embedded in grass
                Image("timer_bush_berry")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .position(
                        x: w - 50,
                        y: bottomAt(groundY + 45, height: 70)
                    )

                // ========== LAYER 8: BUTTERFLIES ==========
                FloatingButterfly(imageName: "timer_butterfly_a", size: 32)
                    .position(x: w * 0.20, y: h * 0.42)

                FloatingButterfly(imageName: "timer_butterfly_b", size: 28)
                    .position(x: w * 0.75, y: h * 0.38)
            }
        }
        .ignoresSafeArea()
    }
}
