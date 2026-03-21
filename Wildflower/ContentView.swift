import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear

        let normalAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .font: UIFont(name: "Pixelify Sans", size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Pixelify Sans Bold", size: 10) ?? UIFont.boldSystemFont(ofSize: 10)
        ]

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            TimerView()
                .tabItem {
                    Image("icon_timer_pixel")
                        .renderingMode(.original)
                    Text("Timer")
                }
                .tag(0)

            GardenView()
                .tabItem {
                    Image("icon_garden_pixel")
                        .renderingMode(.original)
                    Text("Garden")
                }
                .tag(1)

            MarketView()
                .tabItem {
                    Image("icon_market_pixel")
                        .renderingMode(.original)
                    Text("Market")
                }
                .tag(2)

            HouseView()
                .tabItem {
                    Image("icon_house_pixel")
                        .renderingMode(.original)
                    Text("House")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
