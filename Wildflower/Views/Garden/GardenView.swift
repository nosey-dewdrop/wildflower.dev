import SwiftUI

struct GardenView: View {
    var body: some View {
        ZStack {
            Color(hex: "2D5016").ignoresSafeArea()

            VStack(spacing: 16) {
                Image("icon_garden_pixel")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 64, height: 64)

                Text("coming soon")
                    .font(.pixelBold(16))
                    .foregroundColor(.white.opacity(0.6))
                Text("plant flowers, arrange\nyour garden")
                    .font(.pixel(12))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.3))
            }
        }
    }
}

#Preview {
    GardenView()
}
