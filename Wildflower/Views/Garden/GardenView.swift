import SwiftUI
import SwiftData

struct GardenView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]

    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var scale: CGFloat = 3.5
    @State private var lastScale: CGFloat = 3.5

    var body: some View {
        ZStack {
            Color(hex: "2D5016").ignoresSafeArea()

            Image("garden_main")
                .resizable()
                .interpolation(.none)
                .frame(width: 800, height: 800)
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
                            scale = max(0.5, min(8.0, lastScale * value))
                        }
                        .onEnded { _ in
                            lastScale = scale
                        }
                )

            // Overlay UI
            VStack {
                HStack {
                    Text("my garden")
                        .font(.pixelBold(16))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
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
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
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
