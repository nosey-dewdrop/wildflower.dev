import SwiftUI
import SwiftData

struct TimerView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var goals: [Goal]
    @Query private var wallets: [Wallet]

    private var wallet: Wallet? { wallets.first }

    @State private var selectedGoal: Goal?
    @State private var timeElapsed: Int = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var showAddGoal = false
    @State private var showFlowerPicker = false
    @State private var selectedFlower = "daisy"
    @State private var editingGoal: Goal?

    private let flowerTypes = [
        ("daisy", "Daisy"),
        ("tulip", "Tulip"),
        ("rose", "Rose"),
        ("sunflower", "Sunflower"),
        ("lavender", "Lavender"),
    ]

    private var currentFlowerAsset: String {
        let stages = ["\(selectedFlower)_seed", "\(selectedFlower)_sprout", "\(selectedFlower)_bud", "\(selectedFlower)_bloom"]
        let index = min(stageForTime, stages.count - 1)
        return stages[index]
    }

    private var stageForTime: Int {
        switch timeElapsed {
        case 0..<60: return 0
        case 60..<300: return 1
        case 300..<900: return 2
        default: return 3
        }
    }

    private var coinsEarned: Int { timeElapsed / 60 }

    private var formattedTime: String {
        String(format: "%02d:%02d", timeElapsed / 60, timeElapsed % 60)
    }

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height

            ZStack {
                // Living scene
                TimerSceneView()

                // Flower - tap to change type
                Image(currentFlowerAsset)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .scaleEffect(1.2)
                    .animation(.spring(response: 0.6), value: stageForTime)
                    .animation(.spring(response: 0.4), value: selectedFlower)
                    .position(x: w / 2, y: h * 0.655)
                    .onTapGesture {
                        if !isRunning {
                            withAnimation(.spring(response: 0.3)) {
                                showFlowerPicker.toggle()
                            }
                        }
                    }

                // Flower picker overlay
                if showFlowerPicker {
                    VStack(spacing: 0) {
                        Spacer()

                        VStack(spacing: 12) {
                            Text("choose flower")
                                .font(.pixelBold(13))
                                .foregroundColor(.white)

                            HStack(spacing: 16) {
                                ForEach(flowerTypes, id: \.0) { key, name in
                                    Button {
                                        selectedFlower = key
                                        withAnimation(.spring(response: 0.3)) {
                                            showFlowerPicker = false
                                        }
                                    } label: {
                                        VStack(spacing: 6) {
                                            Image("\(key)_bloom")
                                                .resizable()
                                                .interpolation(.none)
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .background(
                                                    selectedFlower == key
                                                        ? Color.white.opacity(0.2)
                                                        : Color.clear
                                                )
                                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                            Text(name)
                                                .font(.pixel(9))
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal, 16)
                        .padding(.bottom, h * 0.15)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Top bar
                HStack {
                    CoinDisplay(amount: (wallet?.coins ?? 0) + coinsEarned)
                    Spacer()
                    Button { showAddGoal = true } label: {
                        Text("+")
                            .font(.pixelBold(22))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.top, 75)

                // Timer + Start button - TOGETHER in sky area
                VStack(spacing: 12) {
                    Text(formattedTime)
                        .font(.pixelBold(44))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.6), radius: 4, x: 2, y: 2)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 0)
                        .scaleEffect(1.4)

                    // Goal selection
                    if !goals.isEmpty && selectedGoal == nil && !isRunning {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(goals) { goal in
                                    Button {
                                        selectedGoal = goal
                                    } label: {
                                        VStack(spacing: 6) {
                                            Text(goal.emoji).font(.system(size: 22))
                                            Text(goal.name).font(.pixel(10)).foregroundColor(.white)
                                        }
                                        .padding(10)
                                        .background(Color.black.opacity(0.4))
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                    .contextMenu {
                                        Button {
                                            editingGoal = goal
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button(role: .destructive) {
                                            modelContext.delete(goal)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else if goals.isEmpty && !isRunning {
                        VStack(spacing: 4) {
                            Text("no goals yet")
                                .font(.pixel(13))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                            Text("tap + to create one")
                                .font(.pixel(10))
                                .foregroundColor(.white.opacity(0.7))
                                .shadow(color: .black, radius: 2, x: 1, y: 1)
                        }
                    }

                    if let goal = selectedGoal, !isRunning {
                        HStack(spacing: 6) {
                            Text(goal.emoji).font(.system(size: 16))
                            Text(goal.name).font(.pixel(12)).foregroundColor(.white)
                        }
                        .padding(.horizontal, 12).padding(.vertical, 8)
                        .background(Color.black.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    }

                    // Start/Stop - right below timer
                    if isRunning {
                        PixelButton("Stop", isDestructive: true) { stopTimer() }
                    } else {
                        PixelButton("Start") { startTimer() }
                    }
                }
                .position(x: w / 2, y: h * 0.47)
            }
        }
        .sheet(isPresented: $showAddGoal) {
            AddGoalView()
        }
        .sheet(item: $editingGoal) { goal in
            AddGoalView(editGoal: goal)
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    private func startTimer() {
        if selectedGoal == nil && !goals.isEmpty { return }
        isRunning = true
        showFlowerPicker = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        if let goal = selectedGoal, timeElapsed > 0 {
            let session = Session(goal: goal, duration: timeElapsed, completed: true)
            modelContext.insert(session)

            // Earn coins
            let earned = timeElapsed / 60
            if earned > 0 {
                if let wallet = wallet {
                    wallet.earn(earned)
                } else {
                    let newWallet = Wallet(coins: earned)
                    modelContext.insert(newWallet)
                }
            }
        }
        timeElapsed = 0
        selectedGoal = nil
    }
}

// MARK: - Pager (swipe left for history)

struct TimerPagerView: View {
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            TimerView()
                .tag(0)
            SessionHistoryView()
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
    }
}

// MARK: - Session History

struct SessionHistoryView: View {
    @Query(sort: \Session.startedAt, order: .reverse) private var sessions: [Session]

    var body: some View {
        ZStack {
            Color(hex: "1A1A2E").ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("history")
                        .font(.pixelBold(18))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(sessions.count) sessions")
                        .font(.pixel(12))
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 70)
                .padding(.bottom, 16)

                if sessions.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Text("no sessions yet")
                            .font(.pixelBold(14))
                            .foregroundColor(.white.opacity(0.5))
                        Text("swipe right to start focusing")
                            .font(.pixel(11))
                            .foregroundColor(.white.opacity(0.3))
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(sessions) { session in
                                SessionRow(session: session)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 80)
                    }
                }
            }
        }
    }
}

struct SessionRow: View {
    let session: Session

    private var minutesDuration: Int {
        session.duration / 60
    }

    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: session.startedAt)
    }

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: session.startedAt)
    }

    var body: some View {
        HStack(spacing: 12) {
            // Goal emoji
            Text(session.goal?.emoji ?? "🌱")
                .font(.system(size: 24))
                .frame(width: 40, height: 40)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 4))

            // Goal name + date
            VStack(alignment: .leading, spacing: 4) {
                Text(session.goal?.name ?? "free focus")
                    .font(.pixelBold(13))
                    .foregroundColor(.white)
                HStack(spacing: 6) {
                    Text(dateString)
                        .font(.pixel(10))
                        .foregroundColor(.white.opacity(0.4))
                    Text(timeString)
                        .font(.pixel(10))
                        .foregroundColor(.white.opacity(0.3))
                }
            }

            Spacer()

            // Duration
            Text("\(minutesDuration) min")
                .font(.pixelBold(14))
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(12)
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    TimerView()
        .modelContainer(for: [Goal.self, Session.self, Wallet.self, GardenItem.self], inMemory: true)
}
