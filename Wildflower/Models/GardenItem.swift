import Foundation
import SwiftData

@Model
final class GardenItem {
    var id: UUID
    var itemName: String
    var category: String // flower, tree, decoration, animal
    var positionX: Double
    var positionY: Double
    var growthStage: Int
    var placedAt: Date

    init(itemName: String, category: String, positionX: Double = 0, positionY: Double = 0, growthStage: Int = 0) {
        self.id = UUID()
        self.itemName = itemName
        self.category = category
        self.positionX = positionX
        self.positionY = positionY
        self.growthStage = growthStage
        self.placedAt = Date()
    }

    var assetName: String {
        let stages: [String]
        switch category {
        case "flower":
            stages = ["\(itemName)_seed", "\(itemName)_sprout", "\(itemName)_bud", "\(itemName)_bloom"]
        case "tree":
            stages = ["\(itemName)_sapling", "\(itemName)_young", "\(itemName)_mature", "\(itemName)_full"]
        default:
            return itemName
        }
        let index = min(growthStage, stages.count - 1)
        return stages[index]
    }

    var displaySize: CGFloat {
        switch category {
        case "flower": return 64
        case "tree": return 96
        case "decoration": return 56
        case "animal": return 48
        default: return 56
        }
    }
}
