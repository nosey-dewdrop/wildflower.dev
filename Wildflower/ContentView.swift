import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color(hex: "1A1A2E").opacity(0.95))

        let normalAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.4),
            .font: UIFont(name: "PixelifySans-Regular", size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(Color(hex: "4A7C59")),
            .font: UIFont(name: "PixelifySans-Bold", size: 10) ?? UIFont.boldSystemFont(ofSize: 10)
        ]

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.4)
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color(hex: "4A7C59"))

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            TimerView()
                .tabItem {
                    Image("icon_timer_pixel")
                        .renderingMode(.template)
                    Text("Timer")
                }
                .tag(0)

            GardenView()
                .tabItem {
                    Image("icon_garden_pixel")
                        .renderingMode(.template)
                    Text("Garden")
                }
                .tag(1)

            MarketView()
                .tabItem {
                    Image("icon_market_pixel")
                        .renderingMode(.template)
                    Text("Market")
                }
                .tag(2)

            HouseView()
                .tabItem {
                    Image("icon_house_pixel")
                        .renderingMode(.template)
                    Text("House")
                }
                .tag(3)
        }
        .tint(Color(hex: "4A7C59"))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
