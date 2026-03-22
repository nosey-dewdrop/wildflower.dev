import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            // Shared scene background behind all pages
            TimerSceneView()
                .ignoresSafeArea()
                .allowsHitTesting(false)

            TabView(selection: $selectedTab) {
                TimerPagerView()
                    .tag(0)
                GardenView()
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Goal.self, Session.self, Wallet.self, GardenItem.self], inMemory: true)
}
