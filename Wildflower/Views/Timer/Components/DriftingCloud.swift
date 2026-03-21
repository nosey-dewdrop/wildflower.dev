import SwiftUI

struct DriftingCloud: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat
    let x: CGFloat
    let y: CGFloat
    let driftAmount: CGFloat
    let duration: Double

    @State private var drifted = false

    var body: some View {
        Image(imageName)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: width, height: height)
            .opacity(0.9)
            .position(
                x: drifted ? x + driftAmount : x,
                y: y
            )
            .onAppear {
                withAnimation(
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true)
                ) {
                    drifted = true
                }
            }
            .allowsHitTesting(false)
    }
}
