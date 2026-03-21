import SwiftUI

extension Font {
    static func pixel(_ size: CGFloat) -> Font {
        .custom("Pixelify Sans", size: size)
    }

    static func pixelBold(_ size: CGFloat) -> Font {
        .custom("Pixelify Sans Bold", size: size)
    }
}

extension View {
    func pixelText() -> some View {
        self
    }
}

struct PixelButton: View {
    let title: String
    let isDestructive: Bool
    let action: () -> Void

    init(_ title: String, isDestructive: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isDestructive = isDestructive
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.pixelBold(14))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 0, x: 1, y: 1)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background {
                    Image(isDestructive ? "button_red" : "button_green")
                        .resizable()
                        .interpolation(.none)
                }
        }
    }
}

struct PixelPanel<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Image("panel_wood")
                .resizable()
                .interpolation(.none)

            content
                .padding(16)
        }
    }
}

struct CoinDisplay: View {
    let amount: Int

    var body: some View {
        HStack(spacing: 6) {
            Image("coin")
                .resizable()
                .interpolation(.none)
                .frame(width: 20, height: 20)
            Text("\(amount)")
                .font(.pixelBold(14))
                .foregroundColor(Color(hex: "FFD700"))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
