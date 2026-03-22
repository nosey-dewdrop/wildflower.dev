import Foundation
import SwiftData

@Model
final class Wallet {
    var id: UUID
    var coins: Int

    init(coins: Int = 0) {
        self.id = UUID()
        self.coins = coins
    }

    func earn(_ amount: Int) {
        coins += amount
    }

    func spend(_ amount: Int) -> Bool {
        guard coins >= amount else { return false }
        coins -= amount
        return true
    }
}
