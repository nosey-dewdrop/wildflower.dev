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
                    TextField("Goal name", text: $name)
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Emoji")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.caption)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 6), spacing: 12) {
                            ForEach(emojis, id: \.self) { emoji in
                                Button {
                                    selectedEmoji = emoji
                                } label: {
                                    Text(emoji)
                                        .font(.title2)
                                        .frame(width: 44, height: 44)
                                        .background(selectedEmoji == emoji ? Color.white.opacity(0.2) : Color.clear)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Color")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.caption)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 12) {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    Circle()
                                        .fill(Color(hex: color))
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                        )
                                }
                            }
                        }
                    }

                    Spacer()

                    Button {
                        let goal = Goal(name: name, emoji: selectedEmoji, colorHex: selectedColor)
                        modelContext.insert(goal)
                        dismiss()
                    } label: {
                        Text("Plant This Goal")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(name.isEmpty ? Color.gray : Color(hex: selectedColor))
                            .cornerRadius(28)
                    }
                    .disabled(name.isEmpty)
                }
                .padding()
            }
            .navigationTitle("New Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    AddGoalView()
        .modelContainer(for: [Goal.self, Session.self], inMemory: true)
}
