import SwiftUI
import SwiftData

struct MarketView: View {
    @Query private var wallets: [Wallet]

    private var wallet: Wallet? { wallets.first }

    var body: some View {
        ZStack {
            Color(hex: "3E2723").ignoresSafeArea()

            VStack {
                HStack {
                    Text("Market")
                        .font(.pixelBold(18))
                        .foregroundColor(.white)
                    Spacer()
                    CoinDisplay(amount: wallet?.coins ?? 0)
                }
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 16) {
                    Image("icon_market_pixel")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)

                    Text("coming soon")
                        .font(.pixelBold(16))
                        .foregroundColor(.white.opacity(0.6))
                    Text("seeds, pots\nfurniture & more")
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
    MarketView()
}
