import Foundation
import SwiftData

@Model
final class Session {
    var id: UUID
    var goal: Goal?
    var startedAt: Date
    var duration: Int
    var completed: Bool

    init(goal: Goal, startedAt: Date = Date(), duration: Int = 0, completed: Bool = false) {
        self.id = UUID()
        self.goal = goal
        self.startedAt = startedAt
        self.duration = duration
        self.completed = completed
    }

    var formattedDuration: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%d:%02d", minutes, seconds)
    }
}
