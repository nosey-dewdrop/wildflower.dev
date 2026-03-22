import SwiftUI
import SwiftData

@main
struct WildflowerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Goal.self, Session.self, Wallet.self])
    }
}
