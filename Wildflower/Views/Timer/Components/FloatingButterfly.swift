import SwiftUI

struct FloatingButterfly: View {
    let imageName: String
    let size: CGFloat

    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var rotation: Double = 0
    @State private var wingFlap: Bool = false

    private let wanderRange: CGFloat = 40

    var body: some View {
        Image(imageName)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: size, height: size)
            .scaleEffect(x: 1, y: wingFlap ? 0.7 : 1.0)
            .rotationEffect(.degrees(rotation))
            .offset(x: offsetX, y: offsetY)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 0.3)
                    .repeatForever(autoreverses: true)
                ) {
                    wingFlap = true
                }

                withAnimation(
                    .easeInOut(duration: Double.random(in: 3...5))
                    .repeatForever(autoreverses: true)
                ) {
                    offsetX = CGFloat.random(in: -wanderRange...wanderRange)
                    offsetY = CGFloat.random(in: -wanderRange / 2...wanderRange / 2)
                    rotation = Double.random(in: -15...15)
                }
            }
    }
}
