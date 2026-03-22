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
        ("flower", "Seeds"),
        ("tree", "Trees"),
        ("decoration", "Decor"),
        ("animal", "Pets")
    ]

    var body: some View {
        ZStack {
            // Dark wood background
            Color(hex: "2A1810").ignoresSafeArea()

            VStack(spacing: 0) {
                // Shop sign header
                VStack(spacing: 4) {
                    Image("panel_wood")
                        .resizable()
                        .interpolation(.none)
                        .frame(height: 50)
                        .overlay {
                            Text("Shop")
                                .font(.pixelBold(20))
                                .foregroundColor(Color(hex: "FFD700"))
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                        }
                }
                .padding(.horizontal)
                .padding(.top, 60)

                // Coin balance
                HStack {
                    Spacer()
                    CoinDisplay(amount: wallet?.coins ?? 0)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)

                // Category shelf tabs
                HStack(spacing: 8) {
                    ForEach(categories, id: \.0) { key, label in
                        Button {
                            selectedCategory = key
                        } label: {
                            Text(label)
                                .font(.pixelBold(11))
                                .foregroundColor(selectedCategory == key ? Color(hex: "FFD700") : .white.opacity(0.4))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    selectedCategory == key
                                        ? Color(hex: "5C3A1E")
                                        : Color(hex: "3D2415")
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(
                                            selectedCategory == key ? Color(hex: "8B6914") : Color.clear,
                                            lineWidth: 1
                                        )
                                )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                // Shelf divider
                Rectangle()
                    .fill(Color(hex: "5C3A1E"))
                    .frame(height: 3)
                    .padding(.horizontal)

                // Items on shelves
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 4) {
                        ForEach(ShopItem.forCategory(selectedCategory)) { item in
                            ShelfItemCard(
                                item: item,
                                canAfford: (wallet?.coins ?? 0) >= item.price,
                                owned: gardenItems.filter({ $0.itemName == item.name }).count
                            ) {
                                buyItem(item)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
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
                .padding(24)
                .background(Color(hex: "2A1810").opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "8B6914"), lineWidth: 2)
                )
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
            positionY: Double.random(in: 150...500)
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

struct ShelfItemCard: View {
    let item: ShopItem
    let canAfford: Bool
    let owned: Int
    let onBuy: () -> Void

    var body: some View {
        Button(action: onBuy) {
            VStack(spacing: 6) {
                // Item on shelf
                Image(item.previewAsset)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 44, height: 44)

                Text(item.displayName)
                    .font(.pixel(9))
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)

                // Price tag
                HStack(spacing: 2) {
                    Image("coin")
                        .resizable()
                        .interpolation(.none)
                        .frame(width: 12, height: 12)
                    Text("\(item.price)")
                        .font(.pixelBold(10))
                        .foregroundColor(canAfford ? Color(hex: "FFD700") : .gray)
                }

                if owned > 0 {
                    Text("x\(owned)")
                        .font(.pixel(8))
                        .foregroundColor(.white.opacity(0.3))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 4)
            .background(Color(hex: "3D2415"))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(hex: "5C3A1E"), lineWidth: 1)
            )
        }
        .disabled(!canAfford)
        .opacity(canAfford ? 1.0 : 0.5)
    }
}

#Preview {
    MarketView()
        .modelContainer(for: [Goal.self, Session.self, Wallet.self, GardenItem.self], inMemory: true)
}
