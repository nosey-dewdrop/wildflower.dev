import SwiftUI

struct MarketView: View {
    var body: some View {
        ZStack {
            Color(hex: "3E2723").ignoresSafeArea()

            VStack {
                HStack {
                    Text("Market")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Spacer()

                    HStack(spacing: 4) {
                        Image("coin")
                            .resizable()
                            .interpolation(.none)
                            .frame(width: 20, height: 20)
                        Text("0")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(hex: "FFD700"))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(hex: "5D4037"))
                    .cornerRadius(16)
                }
                .padding()

                Spacer()

                VStack(spacing: 16) {
                    Image("icon_market")
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                        .opacity(0.6)

                    Text("Coming soon")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.subheadline)
                    Text("Seeds, pots, furniture\nand more")
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
    MarketView()
}
