import SwiftUI
import SwiftData

struct GardenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var gardenItems: [GardenItem]

    @State private var draggedItem: GardenItem?
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Grass background
                Color(hex: "2D5016").ignoresSafeArea()

                // Subtle grass gradient
                LinearGradient(
                    colors: [Color(hex: "3A6B1E").opacity(0.5), Color(hex: "2D5016"), Color(hex: "244210")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // Header
                VStack {
                    HStack {
                        Text("Garden")
                            .font(.pixelBold(18))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                        Spacer()
                        Text("\(gardenItems.count) items")
                            .font(.pixel(12))
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(.horizontal)
                    .padding(.top, 70)
                    Spacer()
                }

                // House
                Image("icon_house_pixel")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 2)
                    .position(x: geo.size.width * 0.8, y: geo.size.height * 0.3)

                // Garden items
                ForEach(gardenItems) { item in
                    let isDragging = draggedItem?.id == item.id

                    Image(item.assetName)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: item.displaySize, height: item.displaySize)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 2)
                        .scaleEffect(isDragging ? 1.2 : 1.0)
                        .position(
                            x: item.positionX + (isDragging ? dragOffset.width : 0),
                            y: item.positionY + (isDragging ? dragOffset.height : 0)
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    draggedItem = item
                                    dragOffset = value.translation
                                }
                                .onEnded { value in
                                    item.positionX += value.translation.width
                                    item.positionY += value.translation.height
                                    // Clamp to screen bounds
                                    item.positionX = max(30, min(geo.size.width - 30, item.positionX))
                                    item.positionY = max(100, min(geo.size.height - 80, item.positionY))
                                    dragOffset = .zero
                                    draggedItem = nil
                                }
                        )
                        .animation(.spring(response: 0.3), value: isDragging)
                }

                // Empty state
                if gardenItems.isEmpty {
                    VStack(spacing: 12) {
                        Text("empty garden")
                            .font(.pixelBold(14))
                            .foregroundColor(.white.opacity(0.5))
                        Text("buy items from the market\nto fill your garden")
                            .font(.pixel(11))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.3))
                    }
                }
            }
        }
    }
}

#Preview {
    GardenView()
        .modelContainer(for: [GardenItem.self], inMemory: true)
}
