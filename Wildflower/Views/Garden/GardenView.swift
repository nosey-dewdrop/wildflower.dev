import SwiftUI
import SwiftData

struct GardenTile: Identifiable {
    let id = UUID()
    var x: Int
    var y: Int
    var type: TileType

    enum TileType: Equatable {
        case grass
        case grassFlowers
        case grassClover
        case dirtPlot
        case plantedPlot(stage: Int)
        case tree
        case bush
    }

    var isPlantable: Bool {
        switch type {
        case .grass, .grassFlowers, .grassClover: return true
        default: return false
        }
    }

    var imageName: String {
        switch type {
        case .grass: return "grass_1"
        case .grassFlowers: return "grass_2"
        case .grassClover: return "grass_3"
        case .dirtPlot: return "dirt_plot_empty"
        case .plantedPlot(let stage):
            let stages = ["daisy_1_seed", "daisy_2_sprout", "daisy_3_bud", "daisy_4_blooming", "daisy_5_full_bloom"]
            return stages[min(stage, 4)]
        case .tree: return "grass_1"
        case .bush: return "grass_1"
        }
    }

    var tileColor: Color {
        switch type {
        case .grass: return Color(hex: "4A8C38")
        case .grassFlowers: return Color(hex: "5A9C48")
        case .grassClover: return Color(hex: "3E7C2E")
        case .dirtPlot: return Color(hex: "5C3A1E")
        case .plantedPlot: return Color(hex: "5C3A1E")
        case .tree: return Color(hex: "2E6B1E")
        case .bush: return Color(hex: "3A7A2A")
        }
    }
}

struct GardenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]

    @State private var tiles: [[GardenTile]] = []
    @State private var offset = CGSize.zero
    @State private var lastOffset = CGSize.zero
    @State private var scale: CGFloat = 2.0
    @State private var lastScale: CGFloat = 2.0
    @State private var selectedTool: GardenTool = .hand

    private let gardenSize = 16
    private let tileSize: CGFloat = 32

    enum GardenTool {
        case hand, plant, dig
    }

    var body: some View {
        ZStack {
            Color(hex: "2D5016").ignoresSafeArea()

            gardenGrid
                .gesture(dragGesture)
                .gesture(magnifyGesture)

            VStack {
                topBar
                Spacer()
                gardenToolbar
            }
        }
        .onAppear {
            if tiles.isEmpty { generateGarden() }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            Text("my garden")
                .font(.pixel(10))
                .foregroundColor(.white)
                .padding(.top, 4)
                .shadow(color: .black, radius: 0, x: 1, y: 1)
            Spacer()
            CoinDisplay(amount: goals.reduce(0) { $0 + $1.totalSeconds / 60 })
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }

    // MARK: - Garden Grid

    private var gardenGrid: some View {
        let st = tileSize * scale
        let totalW = CGFloat(gardenSize) * st
        let totalH = CGFloat(gardenSize) * st

        return VStack(spacing: 0) {
            ForEach(0..<gardenSize, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<gardenSize, id: \.self) { col in
                        tileView(row: row, col: col, size: st)
                    }
                }
            }
        }
        .frame(width: totalW, height: totalH)
        .offset(offset)
    }

    @ViewBuilder
    private func tileView(row: Int, col: Int, size: CGFloat) -> some View {
        if row < tiles.count, col < tiles[row].count {
            let tile = tiles[row][col]
            ZStack {
                Rectangle()
                    .fill(tile.tileColor)
                    .frame(width: size, height: size)

                if case .plantedPlot(let stage) = tile.type {
                    let stages = ["daisy_1_seed", "daisy_2_sprout", "daisy_3_bud", "daisy_4_blooming", "daisy_5_full_bloom"]
                    Image(stages[min(stage, 4)])
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: size * 0.8, height: size * 0.8)
                }

                if tile.type == .dirtPlot {
                    Rectangle()
                        .stroke(Color.brown.opacity(0.5), lineWidth: 1)
                        .frame(width: size, height: size)
                }

                if tile.type == .tree {
                    Circle()
                        .fill(Color(hex: "2E6B1E"))
                        .frame(width: size * 0.8, height: size * 0.8)
                    Circle()
                        .fill(Color(hex: "3A8828"))
                        .frame(width: size * 0.5, height: size * 0.5)
                        .offset(x: -2, y: -2)
                }

                if tile.type == .bush {
                    Circle()
                        .fill(Color(hex: "3A7A2A"))
                        .frame(width: size * 0.6, height: size * 0.5)
                }
            }
            .onTapGesture {
                handleTileTap(row: row, col: col)
            }
        }
    }

    // MARK: - Gestures

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if selectedTool == .hand {
                    offset = CGSize(
                        width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height
                    )
                }
            }
            .onEnded { _ in lastOffset = offset }
    }

    private var magnifyGesture: some Gesture {
        MagnifyGesture()
            .onChanged { value in
                scale = min(max(lastScale * value.magnification, 0.8), 4.0)
            }
            .onEnded { _ in lastScale = scale }
    }

    // MARK: - Toolbar

    private var gardenToolbar: some View {
        HStack(spacing: 16) {
            toolBtn(.hand, "hand.raised.fill", "move")
            toolBtn(.dig, "square.grid.2x2", "dig")
            toolBtn(.plant, "leaf.fill", "plant")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.bottom, 8)
    }

    private func toolBtn(_ tool: GardenTool, _ icon: String, _ label: String) -> some View {
        Button {
            selectedTool = tool
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(selectedTool == tool ? Color(hex: "4A7C59") : .white.opacity(0.6))
                Text(label)
                    .font(.pixel(5))
                    .foregroundColor(selectedTool == tool ? Color(hex: "4A7C59") : .white.opacity(0.4))
                    .padding(.top, 2)
            }
            .frame(width: 60, height: 50)
        }
    }

    // MARK: - Actions

    private func handleTileTap(row: Int, col: Int) {
        guard selectedTool != .hand else { return }
        guard row < tiles.count, col < tiles[row].count else { return }

        switch selectedTool {
        case .hand: break
        case .dig:
            if tiles[row][col].isPlantable {
                tiles[row][col].type = .dirtPlot
            }
        case .plant:
            if tiles[row][col].type == .dirtPlot {
                tiles[row][col].type = .plantedPlot(stage: 0)
                for i in 1...4 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.8) {
                        if row < tiles.count, col < tiles[row].count {
                            tiles[row][col].type = .plantedPlot(stage: i)
                        }
                    }
                }
            }
        }
    }

    private func generateGarden() {
        tiles = (0..<gardenSize).map { row in
            (0..<gardenSize).map { col in
                let rand = Int.random(in: 0..<100)
                let type: GardenTile.TileType
                if rand < 60 { type = .grass }
                else if rand < 78 { type = .grassFlowers }
                else if rand < 90 { type = .grassClover }
                else if rand < 95 { type = .bush }
                else if rand < 98 { type = .tree }
                else { type = .grass }
                return GardenTile(x: col, y: row, type: type)
            }
        }
    }
}

#Preview {
    GardenView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
