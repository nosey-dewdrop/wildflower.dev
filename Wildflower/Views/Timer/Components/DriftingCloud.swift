import SwiftUI

struct DriftingCloud: View {
    let imageName: String
    let width: CGFloat
    let y: CGFloat
    let startX: CGFloat
    let endX: CGFloat
    let duration: Double

    @State private var atEnd = false

    var body: some View {
        GeometryReader { geo in
            let centerX = geo.size.width / 2

            Image(imageName)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: width, height: width * 0.4)
                .opacity(0.8)
                .position(
                    x: (atEnd ? endX : startX) + centerX,
                    y: y
                )
                .animation(
                    .linear(duration: duration)
                    .repeatForever(autoreverses: true),
                    value: atEnd
                )
                .onAppear { atEnd = true }
        }
        .allowsHitTesting(false)
    }
}
