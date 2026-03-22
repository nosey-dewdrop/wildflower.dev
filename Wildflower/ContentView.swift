import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    private let tabs: [(icon: String, label: String)] = [
        ("icon_timer_pixel", "Timer"),
        ("icon_garden_pixel", "Garden"),
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case 0: TimerPagerView()
                case 1: GardenView()
                default: TimerPagerView()
                }
            }
            .ignoresSafeArea()

            // Custom tab bar
            HStack {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 2) {
                            Image(tabs[index].icon)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .opacity(selectedTab == index ? 1.0 : 0.5)

                            Text(tabs[index].label)
                                .font(.pixel(10))
                                .foregroundColor(selectedTab == index ? .white : .white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Goal.self, Session.self, Wallet.self, GardenItem.self], inMemory: true)
}
