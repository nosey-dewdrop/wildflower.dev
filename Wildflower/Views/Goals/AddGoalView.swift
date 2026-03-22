import SwiftUI
import SwiftData

struct AddGoalView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var selectedEmoji = "🌸"
    @State private var selectedColor = "4A7C59"

    private let emojis = ["🌸", "📚", "💻", "🎨", "🏋️", "🎵", "✍️", "🧘", "📖", "🎯", "💡", "🌿"]
    private let colors = ["4A7C59", "E76F51", "5E60CE", "F4A261", "2A9D8F", "E63946", "457B9D", "6D597A"]

    var body: some View {
        ZStack {
            // Grass background
            Color(hex: "2D5016").ignoresSafeArea()

            // Grass texture overlay
            Image("grass_tile_a")
                .resizable(resizingMode: .tile)
                .interpolation(.none)
                .opacity(0.15)
                .ignoresSafeArea()

            Color.black.opacity(0.25).ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("x")
                            .font(.pixelBold(18))
                            .foregroundColor(.white.opacity(0.7))
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                    }
                    Spacer()
                    Text("new goal")
                        .font(.pixelBold(16))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                    Spacer()
                    // Balance for spacing
                    Text("x").font(.pixelBold(18)).opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 24)

                // Content in pixel panel style
                VStack(spacing: 20) {
                    // Name input
                    VStack(alignment: .leading, spacing: 6) {
                        Text("name")
                            .font(.pixel(11))
                            .foregroundColor(.white.opacity(0.6))
                            .shadow(color: .black, radius: 1, x: 1, y: 1)

                        TextField("", text: $name, prompt: Text("what to focus on?").foregroundColor(.white.opacity(0.3)))
                            .font(.pixel(14))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                            )
                    }

                    // Emoji picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("icon")
                            .font(.pixel(11))
                            .foregroundColor(.white.opacity(0.6))
                            .shadow(color: .black, radius: 1, x: 1, y: 1)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 10) {
                            ForEach(emojis, id: \.self) { emoji in
                                Button {
                                    selectedEmoji = emoji
                                } label: {
                                    Text(emoji)
                                        .font(.system(size: 22))
                                        .frame(width: 42, height: 42)
                                        .background(
                                            selectedEmoji == emoji
                                                ? Color.white.opacity(0.25)
                                                : Color.black.opacity(0.3)
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(
                                                    selectedEmoji == emoji ? Color.white.opacity(0.5) : Color.clear,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            }
                        }
                    }

                    // Color picker
                    VStack(alignment: .leading, spacing: 6) {
                        Text("color")
                            .font(.pixel(11))
                            .foregroundColor(.white.opacity(0.6))
                            .shadow(color: .black, radius: 1, x: 1, y: 1)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hex: color))
                                        .frame(width: 50, height: 36)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(
                                                    selectedColor == color ? Color.white : Color.black.opacity(0.3),
                                                    lineWidth: selectedColor == color ? 3 : 1
                                                )
                                        )
                                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 2)
                                }
                            }
                        }
                    }

                    // Preview
                    if !name.isEmpty {
                        HStack(spacing: 8) {
                            Text(selectedEmoji)
                                .font(.system(size: 20))
                            Text(name)
                                .font(.pixel(13))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(hex: selectedColor).opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(response: 0.4), value: name)
                    }

                    Spacer()

                    // Plant button
                    PixelButton("Plant") {
                        let goal = Goal(name: name, emoji: selectedEmoji, colorHex: selectedColor)
                        modelContext.insert(goal)
                        dismiss()
                    }
                    .opacity(name.isEmpty ? 0.5 : 1)
                    .disabled(name.isEmpty)
                    .padding(.bottom, 8)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    AddGoalView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
