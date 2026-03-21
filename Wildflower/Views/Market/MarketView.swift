import SwiftUI

struct MarketView: View {
    var body: some View {
        ZStack {
            Color(hex: "3E2723").ignoresSafeArea()

            VStack {
                HStack {
                    Text("Market")
                        .font(.pixel(12))
                        .foregroundColor(.white)
                    Spacer()
                    CoinDisplay(amount: 0)
                }
                .padding()

                Spacer()

                VStack(spacing: 16) {
                    Image("icon_market")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)

                    Text("coming soon")
                        .font(.pixel(10))
                        .foregroundColor(.white.opacity(0.6))
                    Text("seeds, pots\nfurniture & more")
                        .font(.pixel(6))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.3))
                }

                Spacer()
            }
        }
    }
}

#Preview {
    MarketView()
}
