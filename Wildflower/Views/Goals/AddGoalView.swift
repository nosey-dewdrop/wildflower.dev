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
        NavigationStack {
            ZStack {
                Color(hex: "1A1A2E").ignoresSafeArea()

                VStack(spacing: 24) {
                    TextField("", text: $name, prompt: Text("goal name").foregroundColor(.white.opacity(0.3)))
                        .font(.pixel(14))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                    VStack(alignment: .leading, spacing: 8) {
                        Text("emoji")
                            .font(.pixel(12))
                            .foregroundColor(.white.opacity(0.5))
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 12) {
                            ForEach(emojis, id: \.self) { emoji in
                                Button {
                                    selectedEmoji = emoji
                                } label: {
                                    Text(emoji)
                                        .font(.system(size: 24))
                                        .frame(width: 44, height: 44)
                                        .background(selectedEmoji == emoji ? Color.white.opacity(0.2) : Color.clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("color")
                            .font(.pixel(12))
                            .foregroundColor(.white.opacity(0.5))
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(hex: color))
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4)
                                                .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                        )
                                }
                            }
                        }
                    }

                    Spacer()

                    PixelButton("Plant This Goal") {
                        let goal = Goal(name: name, emoji: selectedEmoji, colorHex: selectedColor)
                        modelContext.insert(goal)
                        dismiss()
                    }
                    .opacity(name.isEmpty ? 0.5 : 1)
                    .disabled(name.isEmpty)
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("new goal")
                        .font(.pixelBold(14))
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("x")
                            .font(.pixelBold(16))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    AddGoalView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
