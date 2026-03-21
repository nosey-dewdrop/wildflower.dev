import SwiftUI
import SwiftData

struct GardenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]

    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    private let tileSize: CGFloat = 64
    private let gridSize = 40

    private let grassTiles = ["grass_tile_a", "grass_tile_b"]

    private func grassTile(for row: Int, col: Int) -> String {
        let hash = (row * 7 + col * 13 + row * col * 3) % grassTiles.count
        return grassTiles[abs(hash)]
    }

    private func hasDecoration(row: Int, col: Int) -> String? {
        let hash = (row * 31 + col * 17 + row * col) % 60
        if hash == 0 { return "tree_topdown" }
        if hash == 5 || hash == 22 { return "bush_topdown" }
        if hash == 12 || hash == 35 { return "rocks" }
        return nil
    }

    private func flowerAt(row: Int, col: Int) -> Goal? {
        let index = row * gridSize + col
        if index < goals.count {
            return goals[index]
        }
        return nil
    }

    private func stageImage(for goal: Goal) -> String {
        let totalMinutes = goal.totalSeconds / 60
        switch totalMinutes {
        case 0..<1: return "daisy_1_seed"
        case 1..<5: return "daisy_2_sprout"
        case 5..<15: return "daisy_3_bud"
        case 15..<30: return "daisy_4_blooming"
        default: return "daisy_5_full_bloom"
        }
    }

    var body: some View {
        ZStack {
            Color(hex: "2D5016").ignoresSafeArea()

            let gardenContent = ZStack {
                VStack(spacing: 0) {
                    ForEach(0..<gridSize, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<gridSize, id: \.self) { col in
                                ZStack {
                                    Image(grassTile(for: row, col: col))
                                        .resizable()
                                        .interpolation(.none)
                                        .frame(width: tileSize, height: tileSize)

                                    if let goal = flowerAt(row: row, col: col) {
                                        ZStack {
                                            Image("dirt_plot")
                                                .resizable()
                                                .interpolation(.none)
                                                .frame(width: tileSize, height: tileSize)
                                                .opacity(0.7)

                                            Image(stageImage(for: goal))
                                                .resizable()
                                                .interpolation(.none)
                                                .scaledToFit()
                                                .frame(width: tileSize * 0.7, height: tileSize * 0.7)
                                        }
                                    } else if let deco = hasDecoration(row: row, col: col) {
                                        Image(deco)
                                            .resizable()
                                            .interpolation(.none)
                                            .scaledToFit()
                                            .frame(width: deco == "tree_topdown" ? tileSize : tileSize * 0.6,
                                                   height: deco == "tree_topdown" ? tileSize : tileSize * 0.6)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            gardenContent
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = max(0.3, min(3.0, lastScale * value))
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )

            VStack {
                HStack {
                    Text("my garden")
                        .font(.pixelBold(16))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                    Spacer()
                    CoinDisplay(amount: 0)
                }
                .padding(.horizontal)
                .padding(.top, 4)

                Spacer()

                if goals.isEmpty {
                    VStack(spacing: 12) {
                        Image("daisy_1_seed")
                            .resizable()
                            .interpolation(.none)
                            .scaledToFit()
                            .frame(width: 48, height: 48)

                        Text("start focusing\nto plant flowers")
                            .font(.pixel(12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                    }
                    .padding(16)
                    .background(Color.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    GardenView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
