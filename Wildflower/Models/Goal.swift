import Foundation
import SwiftData
import SwiftUI

@Model
final class Goal {
    var id: UUID
    var name: String
    var emoji: String
    var colorHex: String
    var deadline: Date?
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \Session.goal)
    var sessions: [Session]

    init(name: String, emoji: String, colorHex: String, deadline: Date? = nil) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
        self.colorHex = colorHex
        self.deadline = deadline
        self.createdAt = Date()
        self.sessions = []
    }

    var color: Color {
        Color(hex: colorHex)
    }

    var totalSeconds: Int {
        sessions.filter(\.completed).reduce(0) { $0 + $1.duration }
    }

    var totalFormattedTime: String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }

    var daysUntilDeadline: Int? {
        guard let deadline else { return nil }
        return Calendar.current.dateComponents([.day], from: Date(), to: deadline).day
    }
}
