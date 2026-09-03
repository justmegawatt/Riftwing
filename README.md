# Riftwright

**Working title:** Riftwright
**Genre:** 2D top-down action-roguelite
**Engine:** Godot 4.7+ (GDScript, strongly typed)

## One-line pitch

A 2D top-down hunter/gate action-roguelite where you did not receive a Class. You received a Key that can rewrite the dungeon — and the invoice arrives in the city.

## Core Hook

Most Awakened receive a licensed Resonance (class). You receive a **Key** that grants **authorship** over gates:
- Lock a room
- Rewrite a Gate Law
- Steal an exit
- Invert an enemy buff
- Force a shortcut

**Two resources:**
- **Key Charges** (run resource) - Spent to fire rewrite verbs
- **Canon** (meta/story) - Invoice for rewriting reality

## Current Status: Slice 0

This is a playable vertical slice demonstrating the core loop:

**Title → Pick Resonance → Hub → Gate Run (3 rooms + boss) → Results → Talent Forge → Loop**

### Features Implemented

- Three starting Resonances: Striker, Warden, Hexer
- 8-way movement + dash with i-frames
- Basic melee attack
- Resonance-specific ability (Q)
- Key Charge rewrite system (F key - seals an enemy)
- 3 rooms + boss gate run
- Enemy AI with telegraph + attack
- Results screen with Essence/Fragments/Canon
- Talent system with persistent unlocks
- Save/load system (user://riftwright_save.json)

### Controls

- **WASD / Arrow Keys**: Move
- **Space / Gamepad B**: Dash
- **Left Click / Gamepad A**: Basic attack
- **Q / Gamepad X**: Resonance ability
- **F / Gamepad LB**: Rewrite (costs 1 Key Charge)
- **E / Gamepad A**: Interact
- **ESC / Start**: Pause

### Content

- **Resonances**: Ironveil Striker, Aegisthorn Warden, Ashcant Hexer
- **Enemies**: Void Thrall (regular), Void Brute (boss)
- **Gate**: Fissure (Grade F)
- **Talents**: One per Resonance + Keywright unlock

### Architecture

- **Autoloads**: Events, App, SaveService, AudioRouter, ContentDB
- **Resources**: All game data lives in .tres files under `content/`
- **Systems**: Separated by folder (actors, combat, gate, meta, run, progression)
- **No god objects**: Thin autoloads, signal-based communication

## Running the Project

1. Open in Godot 4.7+
2. Press F5
3. Select a Resonance
4. Enter the gate from the hub
5. Clear 3 rooms + boss or die trying
6. Spend Essence on talents
7. Quit and relaunch - progress persists

## Project Structure

```
res://
  autoload/          - Five thin autoloads (Events, App, SaveService, AudioRouter, ContentDB)
  content/           - All .tres game data (resonances, abilities, talents, enemies, gates)
  resources_src/     - Resource class definitions (AbilityDef, ResonanceDef, etc.)
  src/               - GDScript controllers (actors, combat, gate, meta, run, progression)
  scenes/            - .tscn files (boot, ui, hub, gate, actors, combat)
  assets/            - Art, audio, fonts (currently placeholder ColorRects)
```

## What's NOT Built Yet

This slice deliberately excludes:
- Live multiplayer / netcode
- City meta layer (full hub)
- Story acts 2-8
- Real IAP / monetization plugins
- Advanced rewrite verbs beyond "seal room"
- Full talent graph (only 4 talents)
- Procedural city / dungeon-break map
- Analytics / crash reporting
- Localization beyond `en`
- Mobile touch controls

## Design Principles

1. **Data-driven**: All numbers in Resources, not code
2. **No tracking**: No analytics, no fingerprinting, no ads
3. **Ethical monetization**: Cosmetics + convenience, never power
4. **Typed GDScript**: Every var, param, return has a type
5. **Signal-based**: Systems communicate via EventBus, not node paths
6. **Placeholder art**: Colored rectangles + labels for slice 0

## Monetization (Ethics-First)

**No tracking. No ads. No energy gates.**

- Essence (soft): From runs, buys talents
- Fragments (soft): From elites/bosses, unlocks codex
- Credits (soft): From Association board
- Aether Keys (premium): Cosmetics + convenience ONLY

**Never pay-to-win.** Whales and free players have equal power in the same gate.

## Story Spine (Summary)

1. **Ordinary injustice** - Fissure ruptures during drill. Player grabs a Key, not a class.
2. **Unlicensed power** - Association labels you Unlisted. Offers license if you surrender the Key.
3-8. Acts 3-8 outlined in `content/story/` but not implemented in slice 0.

**Canon**: Every rewrite leaves a mark. Streets appear that weren't on the map. NPCs remember rescues that "never happened."

## Alternatives Considered

**Other titles**: Gatewright, Unlicensed, Riftbound, Keybearer
**Not Solo Leveling**: No shadow armies, no monarchs, no System dailies. Verb is EDIT, not grind.

## Next Steps (Post-Slice 0)

- Full hub with NPCs
- More Resonances (Nightthread, Bindscript, Heartwell)
- Expanded talent graphs
- More gate themes (Breach, Rift)
- Story dialogue system
- Echo Duels (async PvP)
- Cosmetic system
- Procedural room generation

## License

(Add license here when determined)

---

**The Association does not own your class.**
