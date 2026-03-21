import SwiftUI

struct HouseView: View {
    var body: some View {
        ZStack {
            Color(hex: "4A3728").ignoresSafeArea()

            VStack {
                Text("My Room")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top)

                Spacer()

                VStack(spacing: 16) {
                    Image("icon_house")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .opacity(0.6)

                    Text("Coming soon")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                    Text("Decorate your room\nwith items from the market")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.3))
                        .font(.caption)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    HouseView()
}
