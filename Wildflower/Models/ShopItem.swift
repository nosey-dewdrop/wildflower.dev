import Foundation

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let displayName: String
    let category: String
    let price: Int
    let previewAsset: String

    static let catalog: [ShopItem] = [
        // Flowers
        ShopItem(name: "daisy", displayName: "Daisy", category: "flower", price: 5, previewAsset: "daisy_bloom"),
        ShopItem(name: "tulip", displayName: "Tulip", category: "flower", price: 8, previewAsset: "tulip_bloom"),
        ShopItem(name: "rose", displayName: "Rose", category: "flower", price: 12, previewAsset: "rose_bloom"),
        ShopItem(name: "sunflower", displayName: "Sunflower", category: "flower", price: 10, previewAsset: "sunflower_bloom"),
        ShopItem(name: "lavender", displayName: "Lavender", category: "flower", price: 8, previewAsset: "lavender_bloom"),

        // Trees
        ShopItem(name: "oak", displayName: "Oak Tree", category: "tree", price: 25, previewAsset: "oak_full"),
        ShopItem(name: "cherry_blossom", displayName: "Sakura", category: "tree", price: 30, previewAsset: "cherry_blossom_full"),

        // Decorations
        ShopItem(name: "fence_wooden", displayName: "Wooden Fence", category: "decoration", price: 3, previewAsset: "fence_wooden"),
        ShopItem(name: "fence_stone", displayName: "Stone Wall", category: "decoration", price: 5, previewAsset: "fence_stone"),
        ShopItem(name: "stone_small", displayName: "Small Rock", category: "decoration", price: 2, previewAsset: "stone_small"),
        ShopItem(name: "stone_large", displayName: "Boulder", category: "decoration", price: 4, previewAsset: "stone_large"),
        ShopItem(name: "pond", displayName: "Pond", category: "decoration", price: 20, previewAsset: "pond"),

        // Animals
        ShopItem(name: "frog", displayName: "Frog", category: "animal", price: 15, previewAsset: "frog"),
        ShopItem(name: "butterfly", displayName: "Butterfly", category: "animal", price: 10, previewAsset: "butterfly"),
        ShopItem(name: "bee", displayName: "Bee", category: "animal", price: 8, previewAsset: "bee"),
        ShopItem(name: "cat", displayName: "Cat", category: "animal", price: 25, previewAsset: "cat"),
        ShopItem(name: "bird", displayName: "Bird", category: "animal", price: 12, previewAsset: "bird"),
        ShopItem(name: "turtle", displayName: "Turtle", category: "animal", price: 15, previewAsset: "turtle"),
        ShopItem(name: "fish", displayName: "Fish", category: "animal", price: 10, previewAsset: "fish"),
    ]

    static func forCategory(_ category: String) -> [ShopItem] {
        catalog.filter { $0.category == category }
    }
}
