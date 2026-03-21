import SpriteKit

class TimerScene: SKScene {

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        anchorPoint = CGPoint(x: 0.5, y: 0)
        setupScene()
    }

    private func setupScene() {
        let w = frame.width
        let h = frame.height

        // ===== LAYER 0: SKY (full screen, behind everything) =====
        let sky = SKSpriteNode(color: UIColor(red: 0.49, green: 0.78, blue: 0.89, alpha: 1.0), size: frame.size)
        sky.anchorPoint = CGPoint(x: 0.5, y: 0)
        sky.position = CGPoint(x: 0, y: 0)
        sky.zPosition = 0
        addChild(sky)

        // ===== LAYER 1: SUN (in sky area) =====
        let sun = SKSpriteNode(imageNamed: "timer_sun_warm")
        sun.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        sun.setScale(3.0)
        sun.position = CGPoint(x: w * 0.25, y: h * 0.82)
        sun.zPosition = 1
        addChild(sun)

        // ===== LAYER 1: CLOUDS (in sky area) =====
        addCloud("timer_cloud_a", scale: 3.0, x: -w * 0.15, y: h * 0.78)
        addCloud("timer_cloud_b", scale: 2.5, x: w * 0.20, y: h * 0.68)
        addCloud("timer_cloud_c", scale: 3.5, x: -w * 0.05, y: h * 0.72)

        // ===== LAYER 2: FAR HILLS =====
        // Bottom edge at h * 0.35, extends up
        let hillsFar = SKSpriteNode(imageNamed: "timer_hills_far")
        hillsFar.anchorPoint = CGPoint(x: 0.5, y: 0)
        hillsFar.size = CGSize(width: w + 40, height: h * 0.18)
        hillsFar.position = CGPoint(x: 0, y: h * 0.35)
        hillsFar.zPosition = 2
        addChild(hillsFar)

        // ===== LAYER 2.5: NEAR HILLS =====
        // Bottom OVERLAPS with far hills bottom area
        // Top of near hills touches bottom of far hills or overlaps
        let hillsNear = SKSpriteNode(imageNamed: "timer_hills_near")
        hillsNear.anchorPoint = CGPoint(x: 0.5, y: 0)
        hillsNear.size = CGSize(width: w + 30, height: h * 0.22)
        hillsNear.position = CGPoint(x: 0, y: h * 0.22)
        hillsNear.zPosition = 2.5
        addChild(hillsNear)

        // ===== LAYER 3: TREES =====
        // Bases sit IN the ground/grass zone, trunks overlap with hills
        let oak = SKSpriteNode(imageNamed: "timer_tree_oak")
        oak.anchorPoint = CGPoint(x: 0.5, y: 0)
        oak.setScale(3.5)
        oak.position = CGPoint(x: -w * 0.25, y: h * 0.18)
        oak.zPosition = 3
        addChild(oak)

        let pine = SKSpriteNode(imageNamed: "timer_tree_pine")
        pine.anchorPoint = CGPoint(x: 0.5, y: 0)
        pine.setScale(3.5)
        pine.position = CGPoint(x: w * 0.30, y: h * 0.18)
        pine.zPosition = 3
        addChild(pine)

        // ===== LAYER 4: GROUND (fills bottom area) =====
        // Solid green ground that connects hills to grass
        let ground = SKSpriteNode(color: UIColor(red: 0.35, green: 0.56, blue: 0.24, alpha: 1.0), size: CGSize(width: w + 20, height: h * 0.25))
        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        ground.position = CGPoint(x: 0, y: 0)
        ground.zPosition = 3.5
        addChild(ground)

        // ===== LAYER 5: GRASS FOREGROUND =====
        // In front of everything ground-level, bottom at y=0
        let grass = SKSpriteNode(imageNamed: "timer_grass_fg")
        grass.anchorPoint = CGPoint(x: 0.5, y: 0)
        grass.size = CGSize(width: w + 20, height: h * 0.22)
        grass.position = CGPoint(x: 0, y: 0)
        grass.zPosition = 5
        addChild(grass)

        // Fence - sitting in grass, left side
        let fence = SKSpriteNode(imageNamed: "timer_fence")
        fence.anchorPoint = CGPoint(x: 0.5, y: 0)
        fence.setScale(2.0)
        fence.position = CGPoint(x: -w * 0.28, y: h * 0.06)
        fence.zPosition = 5.5
        addChild(fence)

        // Bush - sitting in grass, right side
        let bush = SKSpriteNode(imageNamed: "timer_bush_berry")
        bush.anchorPoint = CGPoint(x: 0.5, y: 0)
        bush.setScale(2.0)
        bush.position = CGPoint(x: w * 0.30, y: h * 0.06)
        bush.zPosition = 5.5
        addChild(bush)

        // ===== LAYER 6: BUTTERFLIES =====
        addButterfly("timer_butterfly_a", x: -w * 0.15, y: h * 0.55)
        addButterfly("timer_butterfly_b", x: w * 0.20, y: h * 0.50)
    }

    // MARK: - Cloud helper

    private func addCloud(_ name: String, scale: CGFloat, x: CGFloat, y: CGFloat) {
        let cloud = SKSpriteNode(imageNamed: name)
        cloud.setScale(scale)
        cloud.position = CGPoint(x: x, y: y)
        cloud.zPosition = 1
        cloud.alpha = 0.9
        addChild(cloud)

        // Drift animation
        let drift = SKAction.moveBy(x: 50, y: 0, duration: Double.random(in: 35...55))
        let driftBack = drift.reversed()
        cloud.run(.repeatForever(.sequence([drift, driftBack])))
    }

    // MARK: - Butterfly helper

    private func addButterfly(_ name: String, x: CGFloat, y: CGFloat) {
        let butterfly = SKSpriteNode(imageNamed: name)
        butterfly.setScale(1.5)
        butterfly.position = CGPoint(x: x, y: y)
        butterfly.zPosition = 6
        addChild(butterfly)

        // Wander
        let wander = SKAction.moveBy(
            x: CGFloat.random(in: -30...30),
            y: CGFloat.random(in: -20...20),
            duration: 3
        )
        butterfly.run(.repeatForever(.sequence([wander, wander.reversed()])))

        // Wing flap
        let flapDown = SKAction.scaleY(to: 1.0, duration: 0.25)
        let flapUp = SKAction.scaleY(to: 1.5, duration: 0.25)
        butterfly.run(.repeatForever(.sequence([flapDown, flapUp])))
    }
}
