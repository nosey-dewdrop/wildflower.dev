import SwiftUI

struct HouseView: View {
    var body: some View {
        ZStack {
            Color(hex: "4A3728").ignoresSafeArea()

            VStack {
                HStack {
                    Text("My Room")
                        .font(.pixelBold(18))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 16) {
                    Image("icon_house_pixel")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)

                    Text("coming soon")
                        .font(.pixelBold(16))
                        .foregroundColor(.white.opacity(0.6))
                    Text("decorate your room\nwith market items")
                        .font(.pixel(12))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.3))
                }

                Spacer()
            }
        }
    }
}

#Preview {
    HouseView()
}
