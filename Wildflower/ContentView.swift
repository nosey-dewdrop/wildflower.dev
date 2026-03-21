import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TimerView()
                .tabItem {
                    Image("icon_timer")
                    Text("Timer")
                }
                .tag(0)

            GardenView()
                .tabItem {
                    Image("icon_garden")
                    Text("Garden")
                }
                .tag(1)

            MarketView()
                .tabItem {
                    Image("icon_market")
                    Text("Market")
                }
                .tag(2)

            HouseView()
                .tabItem {
                    Image("icon_house")
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
