# Riftwright

**Working title:** Riftwright  
**Genre:** 2D top-down action-roguelite  
**Engine:** Godot 4.7+ (GDScript, strongly typed)  
**Status:** Complete playable game (v1.0)

## One-line pitch

A 2D top-down hunter/gate action-roguelite where you did not receive a Class. You received a Key that can rewrite the dungeon — and the invoice arrives in the city.

## Core Hook

Most Awakened receive a licensed Resonance (class). You receive a **Key** that grants **authorship** over gates:
- Seal Room - kill an enemy instantly
- Flip Hazard - damage all enemies (invert environmental effects)
- Reroute Exit - force the next door's destination  
- Steal Law - extract Gate Laws from elites into your codex
- Lock Exit - freeze a door (PvP prep)

**Two resources:**
- **Key Charges** (run resource) - Spent to fire rewrite verbs
- **Canon** (meta/story) - Invoice for rewriting reality

## Current Status: Version 1.0 Complete

Full playable game from title screen through endgame:

**Complete Game Loop:** Title → Pick Resonance (6 total) → Hub → Gate Run (5 grades) → Results → Talent/Shop/Codex → Loop

### All Features Implemented

#### Core Systems
- ✅ 5 gate grades: Fissure → Breach → Rift → Sovereign Rift → Black Gate
- ✅ Progressive unlocking: clear a gate 2x to unlock next tier
- ✅ Reward scaling by grade (1x → 5x for Black Gate)
- ✅ 6 playable Resonances (3 starter + 3 unlockable)
- ✅ Full Keywright rewrite verb tree (5 verbs total)
- ✅ Talent system with prereqs and branching paths
- ✅ 8 enemy types across all gate tiers
- ✅ Boss encounters with scaled difficulty

#### Resonances (All 6 Playable)
- **Striker** (Ironveil) - Close-range breaker with dash strike
- **Warden** (Aegisthorn) - Barrier tank with shield bash  
- **Hexer** (Ashcant) - Ranged elemental with flame bolt
- **Nightthread** - Mobility/execute assassin (unlock @ 5 gates cleared)
- **Bindscript** - Control/seals controller (unlock @ 10 gates cleared)
- **Heartwell** - Support/sustain healer (unlock @ 15 gates cleared)

#### Keywright Rewrite Verbs
1. **Seal Room** - Kill one enemy instantly (F key, 1 charge)
2. **Flip Hazard** - Damage all enemies (E key, 1 charge, unlocked via talent)
3. **Steal Law** - Extract Gate Law from elites (R key, 2 charges)
4. **Reroute Exit** - Force next door destination (2 charges, talent unlock)
5. **Lock Exit** - Freeze a door (1 charge, talent unlock)

#### Combat & Progression
- 8-way movement + dash with i-frames
- Basic attack + resonance-specific ability
- Enemy AI with telegraph + attack patterns
- Procedural room generation with enemy variety
- HP/damage/cooldown systems
- Visual feedback (sprite modulation) for all actions
- Player abilities adapt to selected Resonance

#### Layer 2 City Meta
- **Association Standing** - Tracked via gate clears and Echo victories
- **Shop** - Purchase consumables, respec tokens, gate intel with Essence/Fragments
- **Gate Codex** - View all stolen Gate Laws from Steal Law rewrite
- **Talent Forge** - Full talent tree with prereqs for all 6 Resonances + Keywright
- **Relic System** - ItemDef resources, equipped relic slot (Key Fragment example)

#### Story & Dialogue
- 8 story beats outlined (beats 1-8 per spec)
- DialogueBeat system with flags and progression
- Mentor introduction dialogue in hub
- Canon detection dialogue after first rewrite
- Story flags track: mentor_met, canon_noticed
- Manhwa-paced narrative integration

#### Echo Duels (Async PvP)
- Echo enemies spawn randomly in gates (15% chance from room 2+)
- EchoLoadout snapshots capture player builds
- Defeating echoes grants bonus Essence (40) + Standing (25)
- Distinct visual (pink modulate) for readability
- Foundation for full async PvP expansion

#### Monetization (Non-P2W)
- **Cosmetic Shop** with Aether Keys (premium currency)
- 5 cosmetic categories: Key Skins, Auras, Weapon Trails, Hub Apartments, Convenience
- Talent Respec Tokens (convenience, not power)
- Clear separation: Essence/Fragments (gameplay) vs Aether Keys (cosmetic)
- No pay-to-win: cosmetics and convenience ONLY
- OfferDef resources for catalog management

#### Art & Visuals
- Procedurally generated 2D pixel art for all characters
- Player sprites for all 3 starter Resonances (advanced use tinted Striker sprite)
- Enemy sprites for Void Thrall + Void Brute boss
- Tileable floor texture for gate environments
- Title screen background with rift cityscape
- Hub background (Association office interior)
- High-contrast silhouettes for readability per spec

### Controls

| Action | Keyboard | Gamepad |
|---|---|---|
| Move | WASD / Arrows | Left Stick |
| Dash | Space | B |
| Attack | Left Click | A |
| Ability | Q | X |
| Seal Room (Rewrite) | F | LB |
| Flip Hazard | E | A |
| Steal Law | R | Y |
| Interact | E | A |
| Pause | ESC | Start |

### Content Summary

- **6 Resonances** (3 starter + 3 unlockable)
- **20+ Abilities** across all Resonances + Keywright verbs
- **15+ Talent Nodes** with branching paths
- **8 Enemy Types** from Void Thrall to Black Gate Warden
- **5 Gate Themes** (Fissure through Black Gate)
- **8 Story Beats** outlined with 2 dialogue beats implemented
- **5 Cosmetic Categories** in shop
- **1 Relic** (Key Fragment)

### Architecture

- **Autoloads**: Events, App, SaveService, AudioRouter, ContentDB
- **Resources**: All game data lives in .tres files under `content/`
- **Systems**: Separated by folder (actors, combat, gate, meta, run, progression, economy, story, ui)
- **No god objects**: Thin autoloads, signal-based communication
- **Typed GDScript**: Every var, param, return has explicit type
- **Data-driven**: All numbers in Resources, not hardcoded

## Running the Project

1. Open in Godot 4.7+
2. Press F5
3. Select a Resonance (Striker/Warden/Hexer initially)
4. Hub: Choose a gate from the board
5. Clear rooms + boss or die trying
6. Results: collect Essence/Fragments/Canon
7. Talent Forge: spend Essence on talents
8. Shop: purchase items with currencies
9. Gate Codex: view stolen laws
10. Cosmetics: browse cosmetic shop (use debug to grant Aether Keys)
11. Quit and relaunch - full persistence

## Project Structure

```
res://
  autoload/          - Five thin autoloads
  content/           - All .tres game data (resonances, abilities, talents, enemies, gates, story, economy)
  resources_src/     - Resource class definitions (13 types)
  src/               - GDScript controllers (actors, combat, gate, meta, run, progression, economy, story, ui)
  scenes/            - .tscn files (boot, ui, hub, gate, actors, combat)
  assets/art/        - Generated 2D pixel art (characters, enemies, gates, hub, ui)
```

## Systems Implemented

### 1. Gate Progression
- 5 gate grades with escalating difficulty
- Unlock progression: clear 2x to advance
- Reward multipliers: 1x (Fissure) → 5x (Black Gate)
- Room count scales: 3 → 8 rooms

### 2. Resonance System
- 6 unique Resonances with distinct abilities
- Unlocking via total gate clears (5/10/15 thresholds)
- Starting abilities + talent-unlocked abilities
- Role diversity: Breaker/Tank/Ranged/Assassin/Control/Support

### 3. Keywright System
- 5 rewrite verbs with different charge costs
- Talent tree unlocks advanced verbs
- Prereq system: seal → flip → reroute/lock → steal
- Rewrite log tracks Canon accumulation

### 4. Talent System
- Resonance-specific talents (Fang/Hide/Drift)
- Keywright talents (always available)
- Prereq-based unlocking
- Essence cost scaling

### 5. Combat System
- Player: movement, dash, attack, ability, rewrite
- Enemy: telegraph → attack pattern with cooldowns
- Hitbox/hurtbox collision system
- Visual feedback for damage/abilities
- Boss scaling (larger, more HP, more damage)

### 6. Progression System
- Essence (soft, from runs) → talents
- Fragments (soft, from elites) → shop items
- Credits (soft, from board) → hub flavor
- Aether Keys (premium) → cosmetics only
- Canon (story) → tracked per rewrite
- Association Standing → tracked per clear

### 7. Echo System
- Random spawn (15% chance, room 2+)
- EchoLoadout snapshots
- Bonus rewards for defeating
- Visual distinction (pink tint)

### 8. Story System
- 8 story beats outlined
- DialogueBeat resources with flags
- Hub/Results dialogue triggers
- Progressive narrative unlocking

### 9. Shop System
- Essence/Fragments purchasing
- Consumables + convenience items
- Cosmetic shop separate (Aether Keys)
- Owned item tracking

### 10. Codex System
- Stolen Gate Laws display
- Fed by Steal Law rewrite verb
- Lore/flavor text per law

## Design Principles

1. **Data-driven**: All numbers in Resources, not code
2. **No tracking**: No analytics, no fingerprinting, no ads
3. **Ethical monetization**: Cosmetics + convenience, never power
4. **Typed GDScript**: Every var, param, return has a type
5. **Signal-based**: Systems communicate via EventBus, not node paths
6. **Procedural art**: All art generated, no scraped assets

## Monetization (Ethics-First)

**No tracking. No ads. No energy gates.**

### Currencies
- **Essence** (soft): From runs, buys talents
- **Fragments** (soft): From elites/bosses, buys shop items
- **Credits** (soft): From Association board, flavor purchases
- **Aether Keys** (premium): Cosmetics + convenience ONLY

### What Aether Keys Can Buy
- Cosmetics: Key skins, auras, weapon trails, hub apartments
- Convenience: Talent respec tokens, loadout presets

### What Aether Keys CANNOT Buy
- Damage, HP, cooldowns, drop rates
- Energy / tickets that gate playtime
- Gate-clear skips, rank skips, win-rate
- Stronger Resonances (all equal power budget)

**Ethics line:** Whale and free player have equal power in the same gate. Only look and convenience differ.

## Story Spine (Summary)

1. **Ordinary Injustice** - Fissure ruptures. Player grabs Key, not a class.
2. **Unlicensed Power** - Association labels you Unlisted. License offered for Key.
3. **The Deal You Shouldn't Sign** - First Steel vs Key talent fork.
4. **Ranking Economy** - Ranks are markets. First duel where both can flip arena laws.
5. **What Gates Are** - A rewrite leaks. Gates are drafts, not invasions.
6. **Betrayal / Erasure** - Authorship used to frame Unlisted. First real Canon invoice.
7. **The Thing That Writes** - Far Side offer: author or human. Third path: steal the pen.
8. **Open Door** - Raid closed Charter Gate. Plant door in city. Sequel hook.

**Canon**: Every rewrite leaves a mark. Streets appear that weren't on the map. NPCs remember rescues that "never happened."

## What's Different from Solo Leveling

- **Verb is EDIT**, not grind-to-hidden-monarch
- **Antagonist**: ranking economy (Association, guilds, Far Side authors)
- **Talent trees split**: Steel (licensed) vs Keywright (hidden) vs Scar (optional costs)
- **PvP**: "whose ruleset is this arena running?" not raw DPS
- **IAP**: cosmetics/convenience, never damage
- **No**: shadow armies, System dailies, double dungeon, monarchs, Jinwoo-likes

## Development Notes

- All saves persist to `user://riftwright_save.json`
- No analytics, no crash reporting (OFF by default)
- InputMap supports keyboard + mouse + gamepad
- Compatibility renderer for desktop + future mobile
- Placeholder art replaced with generated pixel art
- All scenes F5-playable from title to endgame

## Next Steps (Post-v1)

- More gate themes (different hues per tier)
- More Resonance abilities (3-5 per class)
- Deeper talent graphs (20+ nodes per Resonance)
- Live 1v1 PvP (both players can rewrite arena)
- Guild system (banner, contracts, shared cosmetic well)
- Full story dialogue for all 8 beats
- More relics with unique effects
- Procedural room layouts
- More enemy types per tier
- Seasonal cosmetic passes

---

**The Association does not own your class.**
