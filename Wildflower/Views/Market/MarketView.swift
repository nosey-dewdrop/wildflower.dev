import SwiftUI
import SwiftData

struct MarketView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wallets: [Wallet]
    @Query private var gardenItems: [GardenItem]

    private var wallet: Wallet? { wallets.first }

    @State private var selectedCategory = "flower"
    @State private var purchasedItem: ShopItem?
    @State private var showPurchaseAnimation = false

    private let categories = [
        ("flower", "Flowers"),
        ("tree", "Trees"),
        ("decoration", "Decor"),
        ("animal", "Animals")
    ]

    var body: some View {
        ZStack {
            Color(hex: "3E2723").ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Market")
                        .font(.pixelBold(18))
                        .foregroundColor(.white)
                    Spacer()
                    CoinDisplay(amount: wallet?.coins ?? 0)
                }
                .padding(.horizontal)
                .padding(.top, 70)
                .padding(.bottom, 16)

                // Category tabs
                HStack(spacing: 0) {
                    ForEach(categories, id: \.0) { key, label in
                        Button {
                            selectedCategory = key
                        } label: {
                            Text(label)
                                .font(.pixel(11))
                                .foregroundColor(selectedCategory == key ? .white : .white.opacity(0.4))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(selectedCategory == key ? Color.white.opacity(0.15) : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                // Items grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(ShopItem.forCategory(selectedCategory)) { item in
                            MarketItemCard(
                                item: item,
                                canAfford: (wallet?.coins ?? 0) >= item.price,
                                owned: gardenItems.filter({ $0.itemName == item.name }).count
                            ) {
                                buyItem(item)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }

            // Purchase feedback
            if showPurchaseAnimation, let item = purchasedItem {
                VStack(spacing: 8) {
                    Image(item.previewAsset)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                    Text("bought!")
                        .font(.pixelBold(14))
                        .foregroundColor(Color(hex: "FFD700"))
                }
                .padding(20)
                .background(Color.black.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .transition(.scale.combined(with: .opacity))
            }
        }
    }

    private func buyItem(_ item: ShopItem) {
        guard let wallet = wallet else {
            let newWallet = Wallet(coins: 0)
            modelContext.insert(newWallet)
            return
        }
        guard wallet.spend(item.price) else { return }

        let gardenItem = GardenItem(
            itemName: item.name,
            category: item.category,
            positionX: Double.random(in: 40...300),
            positionY: Double.random(in: 100...500)
        )
        modelContext.insert(gardenItem)

        purchasedItem = item
        withAnimation(.spring(response: 0.4)) {
            showPurchaseAnimation = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation {
                showPurchaseAnimation = false
            }
        }
    }
}

struct MarketItemCard: View {
    let item: ShopItem
    let canAfford: Bool
    let owned: Int
    let onBuy: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Image(item.previewAsset)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 56, height: 56)

            Text(item.displayName)
                .font(.pixel(11))
                .foregroundColor(.white)

            if owned > 0 {
                Text("owned: \(owned)")
                    .font(.pixel(9))
                    .foregroundColor(.white.opacity(0.4))
            }

            Button(action: onBuy) {
                HStack(spacing: 4) {
                    Image("coin")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 14, height: 14)
                    Text("\(item.price)")
                        .font(.pixelBold(12))
                        .foregroundColor(canAfford ? Color(hex: "FFD700") : .gray)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(canAfford ? Color.white.opacity(0.15) : Color.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            .disabled(!canAfford)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    MarketView()
        .modelContainer(for: [Goal.self, Session.self, Wallet.self, GardenItem.self], inMemory: true)
}
