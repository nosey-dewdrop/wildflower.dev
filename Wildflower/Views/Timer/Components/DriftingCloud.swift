import SwiftUI

struct DriftingCloud: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    let yPercent: CGFloat
    let duration: Double
    let startDelay: Double

    @State private var drifted = false

    var body: some View {
        GeometryReader { geo in
            let startX = CGFloat.random(in: geo.size.width * 0.1...geo.size.width * 0.4)
            let endX = startX + CGFloat.random(in: 60...120)

            Image(imageName)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: width, height: height)
                .opacity(0.85)
                .position(
                    x: drifted ? endX : startX,
                    y: geo.size.height * yPercent
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + startDelay) {
                        withAnimation(
                            .linear(duration: duration)
                            .repeatForever(autoreverses: true)
                        ) {
                            drifted = true
                        }
                    }
                }
        }
        .allowsHitTesting(false)
    }
}
