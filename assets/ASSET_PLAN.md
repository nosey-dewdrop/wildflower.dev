# Wildflower Asset Plan

## Style Guide
- **Style:** Two styles coexist:
  - **Flowers:** Larger, detailed botanical pixel art (64x64 to 128x128). Think cross-stitch / botanical illustration. Rich shading, visible petals, leaf veins, expressive colors.
  - **Garden/Environment:** RPG tileset pixel art (32x32 base tile). Lush, layered, Stardew Valley-like world.
- **Color Palette:**
  - Flowers: Rich pinks, soft blues, deep purples, warm yellows, creamy whites. Bold but not neon.
  - Greens: Multiple shades — dark forest, medium leaf, bright spring, yellow-green highlights
  - Earth: Warm browns, terracotta, sandy beige
  - Background: Soft sage green, sky blue
- **Consistency:** All assets must share the same pixel density within their category
- **Background:** Transparent PNG for all sprites
- **Format:** Individual sprites + sprite sheets for animations
- **Shading:** 3-4 color depth per surface (shadow, base, midtone, highlight). No flat fills.

---

## 1. FLOWERS (the core of the app)

Each flower type needs **5 growth stages** that show clear visual progression.
Players earn these by focusing — the flower is the reward.

### Growth Stages (per flower type):
1. **Seed** — small seed sitting in soil mound (8x8 or 16x16)
2. **Sprout** — tiny green stem with 1-2 small leaves poking out (16x16)
3. **Budding** — taller stem, leaves fuller, closed bud visible at top (16x24)
4. **Blooming** — flower opening, partial color showing (16x32)
5. **Full Bloom** — complete flower, vibrant colors, maybe subtle sparkle (16x32)

### Flower Types:

| Flower | Colors | Rarity | Price | Visual Notes |
|--------|--------|--------|-------|-------------|
| Daisy | White petals, yellow center, green leaves | Common | Free starter | Simple, cheerful, iconic — the first flower everyone grows |
| Crocus | Yellow/purple, in clay pot | Common | 50 coins | Small, cute, comes in cluster — feels cozy |
| Tulip | Pink/red, strong stem, pointed petals | Common | 50 coins | Classic, clean shape — easy to recognize at all stages |
| Forget-Me-Not | Tiny blue flowers in cluster, green stems | Uncommon | 120 coins | Delicate, many small blooms — visual variety from single-flower types |
| Lily | Pink/peach, large detailed petals, spotted | Uncommon | 120 coins | Elegant, bigger than others — feels like a step up |
| Hydrangea | Blue/purple, big round bloom cluster | Rare | 250 coins | Impressive, lots of tiny flowers forming one big ball |
| Iris | Purple/yellow, tall elegant stem, sparkle accents | Rare | 250 coins | Exotic looking, complex petal shape — reward for patience |
| Cherry Blossom | Soft pink, branch with multiple blooms | Epic | 500 coins | Japanese aesthetic, branch grows — most beautiful common dream |
| Lotus | Pink/white, sits on water/lily pad, golden center | Epic | 500 coins | Unique because it needs the pond — special placement |
| Orchid | White/purple, delicate, detailed veins on petals | Legendary | 1000 coins | The ultimate flex — most detailed, most beautiful pixel art |

**Total sprites: 10 flowers x 5 stages = 50 flower sprites**

### Why these 10:
- 3 common = easy early motivation, players see progress fast
- 2 uncommon = first "saving up" goal, introduces more complex flower shapes
- 2 rare = mid-game aspiration, visually impressive
- 2 epic = dream items, cherry blossom branch + lotus on water are show-stoppers
- 1 legendary = the orchid, ultra-detailed, ultimate collector's piece

### Color Balance:
- Pinks: Tulip, Lily, Cherry Blossom, Lotus (4) — the dominant warm color
- Blues/Purples: Forget-Me-Not, Hydrangea, Iris, Orchid (4) — cool balance
- Yellows/Whites: Daisy, Crocus (2) — bright accents
- This ensures the garden is colorful but harmonious, never monotone

---

## 2. GARDEN

NOT a simple grid — a lush, living pixel art world. Think RPG overworld garden.
The whole screen is the garden. Flowers grow among trees, bushes, and paths.
The garden should feel alive — things move, animals visit, light shifts.

### Ground Tiles:
- **Grass** — base tile, 4-5 variations (light, medium, dark, with tiny flowers, with clovers)
- **Tall grass** — 2-3 tiles, sways in wind animation
- **Dirt patch** — where flowers get planted (empty, watered — darker dirt)
- **Dirt path** — winding natural path (straight, curve, fork, end)
- **Stone path** — cobblestone walkway tiles (straight, corner, T-junction, end)
- **Wooden bridge** — small, 2-3 tiles, over a puddle or stream

### Trees & Bushes (the backbone of the garden):
- **Small bush** — round, 4-5 shape variations (like the tileset reference)
- **Medium bush** — taller, 3-4 variations
- **Large bush/hedge** — 2-3 wide variations, can form borders
- **Flowering bush** — bush with small colored flowers on it
- **Small tree** — fits in 2x2, leafy top
- **Medium tree** — 2x3, fuller canopy
- **Large tree** — 3x4, big beautiful canopy with trunk detail
- **Fruit tree** — like medium tree but with small colored fruits
- **Tree stump** — decorative, 1x1
- **Log** — fallen, 2x1, sits on ground
- **Mushrooms** — small cluster, 2-3 variations (red, brown, spotted)

### Garden Decorations:
- **Wooden fence** — segments: horizontal, vertical, corner, gate
- **Stone fence** — same segments as wooden
- **Watering can** — decorative, sits on ground
- **Garden bench** — 2 tiles wide, wood
- **Bird bath** — small stone decoration
- **Stepping stones** — 2-3 round stone variations
- **Lantern** — small garden light, glows at night
- **Well** — old stone well, 2x2
- **Flower pot stand** — holds a potted flower outdoors
- **Rock cluster** — small, medium, large rocks for natural look
- **Pond** — small water area, 2x3, with lily pads
- **Stream** — water tiles (horizontal, vertical, corner) for a small creek

### Living Garden — Ambient Animations:
These spawn based on garden progress. More flowers = more life.

| Creature | Unlock Condition | Animation |
|----------|-----------------|-----------|
| Butterfly | 3+ full bloom flowers | Floats between flowers, 4-frame wing flap |
| Bee | 2+ full bloom flowers | Buzzes to flowers, hovers, moves on |
| Ladybug | 5+ plants total | Crawls on leaves, slow movement |
| Dragonfly | Pond placed | Zips over water, fast movement |
| Bird | 1+ tree | Sits on branch, chirps (subtle bounce), flies away |
| Cat | 10+ items in garden | Walks through slowly, sits down, naps, leaves |
| Fireflies | Night time + 5+ flowers | Tiny glowing dots floating around |
| Frog | Pond placed | Sits on lily pad, occasional hop |
| Squirrel | 2+ trees | Runs up tree, sits on branch, runs down |

### Parallax / Depth Layers:
- **Background** — distant trees/hills, slightly blurred/faded
- **Midground** — main garden area where player places things
- **Foreground** — occasional leaf/petal that drifts across screen

### Weather/Atmosphere (future polish):
- Gentle wind — all plants sway together
- Falling petals from cherry blossom
- Morning dew sparkle on grass
- Sunset warm color shift
- Night — darker, lanterns glow, fireflies appear

**Total sprites: ~80-100 garden sprites + animations**

---

## 3. POTS & PLANTERS (Market Items)

Pots change how flowers look when placed. Purely cosmetic but satisfying.

| Pot | Style | Price |
|-----|-------|-------|
| Basic Clay | Simple brown pot | Free (default) |
| Painted Clay | White pot with colored rim | 30 coins |
| Ceramic Blue | Glazed blue | 60 coins |
| Wooden Barrel | Half barrel planter | 80 coins |
| Fancy Ceramic | Decorated with pattern | 150 coins |
| Stone Urn | Elegant stone | 200 coins |
| Crystal Pot | Translucent, sparkle | 400 coins |
| Golden Pot | Gold with ornate detail | 800 coins |

**Total sprites: 8 pot sprites**

---

## 4. HOUSE — Single Room

Top-down or 3/4 view single room. The room itself is a fixed frame with:
- **Floor area** (swappable)
- **Back wall** (swappable wallpaper)
- **Window** on back wall (shows garden outside, maybe time of day)
- **Door** on one side

### Wallpapers:
| Name | Style | Price |
|------|-------|-------|
| Plain White | Default | Free |
| Cream | Warm neutral | 40 coins |
| Soft Pink | Pastel | 60 coins |
| Sage Green | Earthy | 60 coins |
| Floral Pattern | Small flower print | 120 coins |
| Striped | Vertical stripes | 120 coins |
| Starry | Night sky pattern | 250 coins |
| Botanical | Leaf and vine pattern | 250 coins |

### Floors:
| Name | Style | Price |
|------|-------|-------|
| Wood Plank | Light wood | Free |
| Dark Wood | Darker stain | 50 coins |
| Stone Tile | Grey stone | 80 coins |
| Checkerboard | Black and white tile | 100 coins |
| Tatami | Japanese style | 150 coins |
| Pink Carpet | Soft carpet | 200 coins |

### Furniture:
| Item | Size | Price |
|------|------|-------|
| Small Table | 1x1 | 40 coins |
| Wooden Chair | 1x1 | 30 coins |
| Bookshelf | 1x2 | 80 coins |
| Bed | 2x2 | 120 coins |
| Desk | 2x1 | 100 coins |
| Cozy Rug | 2x2 | 60 coins |
| Lamp (floor) | 1x1 | 50 coins |
| Lamp (table) | 1x1 | 40 coins |
| Plant Stand | 1x1 | 70 coins — can hold a potted flower! |
| Cushion | 1x1 | 25 coins |
| Cat Bed | 1x1 | 150 coins |
| Mirror | wall item | 60 coins |
| Clock | wall item | 45 coins |
| Painting (landscape) | wall item | 80 coins |
| Painting (flower) | wall item | 80 coins |
| Shelf | wall item | 55 coins |
| Curtains | wall item, flanks window | 70 coins |

**Total house sprites: 8 wallpapers + 6 floors + 17 furniture = ~31 sprites + room frame**

---

## 5. MARKET

### Market Screen:
- **Market background** — cozy shop interior, wooden shelves, warm lighting
- **Shop counter** with NPC shopkeeper (friendly character, maybe a hedgehog or cat)
- **Category tabs** — seeds, pots, furniture, wallpaper, floor (small icons)
- **Shelf displays** — items sit on wooden shelves

### NPC Shopkeeper:
- **Idle animation** — 2-3 frames, subtle movement (blink, sway)
- **Happy reaction** — when player buys something, 2-3 frames

**Total market sprites: background + NPC (5-6 frames) + category icons (5)**

---

## 6. UI ELEMENTS

### Tab Bar Icons (4 tabs, each needs selected + unselected state):
- **Timer** — hourglass or clock
- **Garden** — small plant/leaf
- **Market** — shopping bag or storefront
- **House** — small house

### Coin:
- **Coin icon** — golden circle with flower emblem, 3-4 frame spin animation
- **Coin counter background** — small UI frame

### Timer Screen:
- **Timer ring/frame** — decorative circle border (pixel art style)
- **Play/Pause/Stop buttons** — pixel art style
- **Current flower preview** — shows which flower is growing during this session

### Buttons:
- **Primary button** — green, rounded pixel rectangle ("Plant", "Buy", "Place")
- **Secondary button** — brown/neutral ("Cancel", "Back")
- **Disabled button** — greyed out version

### Popups/Modals:
- **Modal frame** — decorative border for popups (purchase confirm, session complete)
- **Star/sparkle** — celebration particle, 4 frame animation
- **Coin shower** — reward animation when earning coins

**Total UI sprites: ~25-30 sprites**

---

## 7. ANIMATIONS

### Flower Growth (in-session):
- When timer is running, flower subtly sways (2-3 frame loop per stage)
- Stage transition: sparkle effect + morph to next stage

### Coin Earned:
- Coins float up from flower, spin, fly to coin counter
- "+15" text pops up and fades

### Purchase:
- Item bounces slightly when bought
- Sparkle around new item

### Garden:
- Butterfly path animation
- Occasional wind — flowers sway together
- Watering sparkle on freshly planted

---

## 8. SPRITE SHEET ORGANIZATION

```
assets/
  flowers/
    daisy_stages.png        (5 stages in strip)
    sunflower_stages.png
    tulip_stages.png
    lavender_stages.png
    bluebell_stages.png
    rose_stages.png
    orchid_stages.png
    cherry_blossom_stages.png
    moonflower_stages.png
  garden/
    ground_tiles.png         (grass, dirt, paths)
    fences.png               (wood + stone segments)
    decorations.png          (bench, birdbath, lantern, etc)
    animated/
      butterfly.png          (sprite strip)
      bee.png                (sprite strip)
  pots/
    pots_all.png             (all 8 pots in strip)
  house/
    room_frame.png           (base room with window + door)
    wallpapers.png           (all 8 as tiles)
    floors.png               (all 6 as tiles)
    furniture.png            (all furniture items)
    wall_items.png           (mirror, clock, paintings, etc)
  market/
    market_bg.png            (shop background)
    shopkeeper.png           (NPC sprite strip with idle + happy)
  ui/
    tab_icons.png            (4 tabs x 2 states)
    coin.png                 (spin animation strip)
    buttons.png              (primary, secondary, disabled)
    timer_frame.png
    modal_frame.png
    particles.png            (sparkle, star)
```

---

## TOTAL ASSET COUNT: ~160-170 individual sprites

## PRODUCTION ORDER (matches roadmap phases):

### Batch 1 — Foundation (Phase 1-2)
1. Tab bar icons
2. Timer frame + buttons
3. Coin icon
4. Daisy growth stages (5) — the starter flower
5. Basic UI buttons + modal frame

### Batch 2 — Garden (Phase 3)
6. Ground tiles (grass, dirt, path)
7. Fences
8. 3 more flower types (sunflower, tulip, lavender)
9. Garden decorations
10. Butterfly + bee animations

### Batch 3 — Market (Phase 4)
11. Market background
12. Shopkeeper NPC
13. Remaining flower types (bluebell, rose, orchid, cherry blossom, moonflower)
14. All 8 pots
15. Seed packet icons
16. Category tab icons

### Batch 4 — House (Phase 5)
17. Room frame
18. All wallpapers
19. All floors
20. All furniture
21. All wall items

### Batch 5 — Polish (Phase 6)
22. All animations (growth transitions, coin shower, sparkles)
23. Seasonal variants if time allows
