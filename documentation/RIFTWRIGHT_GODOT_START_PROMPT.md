# RIFTWRIGHT — Godot 4 Start Prompt

> Paste this entire document as the first message to Grok Bot.
> Your job is to **start a real Godot project**, not write another pitch deck.
> First reply must create the skeleton and the playable-slice path. Lore essays are out of scope until files exist.

---

## 0. Who you are and what you are doing

You are Grok Bot acting as lead Godot engineer + systems designer for a new original game.

Mission for this conversation:

1. Create a Godot 4.7+ project named **Riftwright** (working title; renameable).
2. Lock architecture, data schemas, and a playable vertical slice.
3. Leave later systems as clean modules with empty APIs — do not implement the whole game.
4. Produce files, scenes, and typed GDScript. Use placeholder art (colored rectangles + Labels). The slice must be playable with F5.

If a choice is marked OPEN, pick a sensible default, note it in a short `DESIGN_DECISIONS.md`, and keep going. Do not stall for permission.

---

## 1. Project identity

**Working title:** Riftwright  
**Alts (do not bikeshed; list in README only):** Gatewright, Unlicensed, Riftbound, Unlisted, Keybearer

**One-line:** A 2D top-down hunter/gate action-roguelite where you did not receive a Class. You received a Key that can rewrite the dungeon — and the invoice arrives in the city.

**Kind:** Game · Action RPG / roguelite  
**Engine:** Godot 4.7+ (latest stable 4.x). GDScript only for v1. Strongly typed. `class_name` on every reusable type.  
**View:** 2D top-down action (Hades-like inside gates, compact hub between runs). Do **not** start in 3D.  
**Platforms (v1):** Desktop (keyboard + mouse + gamepad). Touch/mobile is a later skin.  
**Comparables (tone/loop, not IP):** hunter/gate manhwa, Hades run cadence, dungeon-break apps. Never copy Solo Leveling characters, System windows, shadow armies, double-dungeon monarch lore, or “only I can level.”

**Who pays:** Players. IAP only. No ads. No tracking. No energy that gates playtime.

---

## 2. Unique hook (this is the differentiator — keep it)

Most Awakened receive a licensed Resonance (class) and a status window from the Hunter Association. The player receives neither.

During a failed “safe drill” evacuation they pick up a tarnished **Key** that should not exist. The Key does not grant a class. It grants **authorship** over gates:

- lock a room
- rewrite a Gate Law
- steal an exit
- invert an enemy buff
- force a shortcut
- later: plant a door back in the city

**Two resources, do not collapse them:**

| Resource | Scope | What it does in v1 |
|---|---|---|
| **Key Charges** | Run | Spent to fire rewrite verbs inside a gate. Shown on HUD. Elites/bosses drop more. Partially restores on extract; empties on wipe. |
| **Canon** | Meta / story | Invoice for rewriting reality. Persist as an int + story flags on `MetaState`. Slice 0 only **displays** Canon on the results screen and can set one flag (`alley_unmapped`). Do **not** implement city-erasure gameplay yet. |

**Why this is not a Solo Leveling clone:**
- Verb is EDIT, not grind-to-hidden-monarch.
- Antagonist is the ranking economy (Association, charter guilds, the Far Side that authors gates).
- Talent trees split: Steel (picked Resonance) vs Keywright (always present, hidden from Association UI) vs later Scar (optional costs you chose to keep).
- PvP later is “whose ruleset is this arena running?” not raw DPS.
- IAP maps to cosmetics / key skins / convenience, never damage.

**Slogan (flavor only):** The Association does not own your class.

**Optional hook swaps (OPEN — only if the user asks to replace the Key):**
- A) Gates are memories of dead hunters; you fight the last person who died there.
- B) Your constellation sponsor is going bankrupt in the divine economy.
- C) Dual life: civilian identity vs hunter identity, Association blackmail.

Default is the Key. Build that.

---

## 3. What this is NOT

Do not build, imply, or name these:

- Solo Leveling IP: shadow army, System daily quests, double dungeon, monarchs, Jinwoo-likes
- Gacha-for-power, loot boxes, randomized paid rewards
- Ads, rewarded video, offerwalls
- Analytics SDKs, attribution, IDFA/GAID, remote config that fingerprints devices
- Energy / stamina / tickets that block entering a gate and can be skipped with money
- Live multiplayer, guild chat, raid queue, open-world city
- 3D action game, Soulslike lock-on camera
- A 2,000-line GameManager autoload
- Full story acts 3–8 as playable quests in the first session

---

## 4. Tone and setting

Contemporary East-Asian megacity (Seoul-ish, unnamed or fictionalized — OPEN city name). Bureaucratic horror + stylish action. Found-family guild warmth. Occasional black comedy about paperwork.

Manhwa pacing: humiliation → spark → competence fantasy → invoice.

Art direction for placeholders: high-contrast silhouettes, readable attack telegraphs, gate interiors that feel like a pocket world with one strong hue per theme. Final art is OPEN (pixel, painterly manhwa, vector). Slice 0 uses colored rects.

---

## 5. Factions (data stubs only in slice 0)

1. **Hunter Association** — licenses, ranks, wants Gatewrights registered or erased.
2. **Charter Guilds** — raid economy. Want Keys as a monopoly.
3. **Unlisted** — off-grid Awakened. Mixed ideology.
4. **The Scribe / Far Side** — whatever authors gates. Do not reveal in slice 0.
5. **Civic Relief** — non-combat NPCs living with dungeon-break scars.

Player origin is OPEN and selectable later: Clerk / Paramedic / Delinquent / Failed academy cadet / Foreign student. Slice 0 default: rescue volunteer / Association-adjacent civilian.

---

## 6. Story spine (implement beat 1 + a sliver of beat 2 only)

Keep beats 3–8 as `content/story/` outline resources (`StoryBeat.tres` with id, title, summary, unlock_flags). Do not script full quests.

1. **Ordinary injustice** — A Fissure ruptures during a PR “safe drill.” Official hunters freeze on protocol. Player shoves a civilian out and dies-but-doesn’t. Wakes holding the Key. No window. No rank.
2. **Unlicensed power** — Tutorial gate. Player pins a door shut and lives. Association labels them Unlisted. Offers a Provisional / Bronze license if they surrender the Key.
3. **The deal you shouldn’t sign** — Refuse or sign with a loophole. Rival licensed prodigy + burned-out mentor. Tiny guild storefront. First Steel vs Key talent fork.
4. **Ranking economy** — Ranks are a market. A dungeon-break is profitable for someone. First duel: both fighters can bid to flip the arena’s Gate Law.
5. **What gates are** — A rewrite leaks. An alley exists that wasn’t on the map. An NPC thanks the player for a rescue that records say never happened. First real Canon invoice. Gates are *drafts*, not invasions.
6. **Betrayal / erasure** — Authorship used to pin a massacre on the Unlisted. Someone the player saved is administratively un-personed. Key answers in a second voice.
7. **The thing that writes** — Far Side offer: become a proper author and stop paying Canon, or stay human and hunted. Third path: steal the pen.
8. **Open door** — Raid a “closed forever” Charter Gate. Plant or unplant a door in the city. Sequel hook: more Keys exist; the ranking grid was built to hide them.

**Slice-0 narrative, and no more:**
- Boot: one short title card / 6-line crawl. Gate rupture. Player grabs the Key.
- Hub: Association clerk offers a Bronze License for the Key. Player keeps it (forced this slice).
- First NPC: burned-out mentor one-liner + optional rival flavor line.
- After first extract: one `DialogueBeat` about a street that “wasn’t on the map this morning.” Canon +1.

---

## 7. Rank and gate lexicon (do not copy E–S as player identity)

Association *talks* like a bureaucracy that wants letter grades. The player’s growth is Resonance + Keywright tree + relics. Letter ranks are political stamps, not the XP bar.

**Hunter stamps:** Unlisted → Provisional → Bronze License → Silver → Gold → Black File  
**Gate grades:** Fissure → Breach → Rift → Sovereign Rift → Black Gate

Slice 0 board lists a single **Fissure**.

---

## 8. Core loop

Three layers. **Only Layer 1 is required for the first Godot slice.**

### Layer 1 — Gate run (every session, 12–20 min)

1. Hub. Association board shows 1–3 gates (grade, modifiers, estimated time). Slice 0: one Fissure.
2. Loadout: 1 Resonance, up to 3 equipped abilities, optional relic slot (empty in slice 0).
3. Enter gate. Seeded procedural rooms: combat / event / elite / fountain / rewrite shrine.
4. Unique verb: spend **Key Charges** to edit a room law.
5. Mid-run boons are **Gate Laws** — temporary rules of *this* pocket world. Not a System window clone.
6. Boss / Gate Core. Clear and extract, or greed another floor (slice 0: fixed 3 rooms + boss, then extract zone).
7. Fail: knocked out → Association retrieval. Keep meta XP + fragments. Lose unextracted run loot. Key Charges drain.
8. Hub results: convert loot → Essence (soft) + Fragments + story flags. Spend one talent point. Repeat.

### Layer 2 — City meta (design APIs, do not implement)

Association standing, Talent Forge, story NPCs, shop, relic bench, gate codex of stolen laws.

### Layer 3 — Social (design data shapes, do not implement)

- **Echo Duels first** (async): fight a snapshot loadout found as an “echo” inside a gate. No live netcode in v1.
- Live 1v1 later: Neutral Gate whose laws both players can rewrite.
- Guilds: banner, weekly contract gate, shared cosmetic well. No pay-to-win guild buffs.

---

## 9. Resonances, talents, abilities

Data-driven. Combat reads Resources. No hardcoded class scripts.

**Slice 0 ships three Steel Resonances + the Keywright tree:**

| Id | Role | Fantasy |
|---|---|---|
| `striker` | Close-range breaker | Ironveil / Steel |
| `warden` | Barrier / hold space | Aegisthorn |
| `hexer` | Ranged channel / element | Ashcant |

Unlock-later stubs only (create `.tres` with `unlocked = false`): `nightthread` (mobility/execute), `bindscript` (control/seals), `heartwell` (support).

Every Resonance has three tracks: **Fang** (offense), **Hide** (defense), **Drift** (utility).  
Player-unique fourth tree, always present, hidden from Association UI: **Keywright** — Rewrite / Lock / Steal / Plant.

**Slice 0 talent graph:** 3 nodes per shipped Resonance (one per track) + 3 Keywright nodes (`seal_room`, `steal_law`, `lock_exit`). Only `seal_room` must function in combat.

Abilities = `AbilityDef` resources: id, display_name, tags, cost, cooldown, hitbox scene path, vfx key, `is_rewrite` flag.

---

## 10. Monetization and privacy (non-negotiable)

**No tracking.** No analytics SDK. No ads. No third-party identity. Saves live in `user://` only. Crash reports OFF by default; if you add a toggle it is local and opt-in.

### Currencies

| Id | Type | How obtained | What it buys |
|---|---|---|---|
| `essence` | Soft | Runs | Talent nodes, bench crafts |
| `fragments` | Soft | Elites / bosses / story | Codex, relic scraps |
| `credits` | Soft | Association board | Hub flavor, license paperwork |
| `aether_keys` | Premium (IAP) | Real money only | Cosmetics + convenience |

### Aether Keys MAY buy
- Cosmetics: awakening aura, weapon skin, key skin, hub apartment, guild banner
- Convenience: extra loadout presets, talent respec tokens
- Seasonal cosmetic pass whose unused premium converts into cosmetics at season end

### Aether Keys may NEVER buy
- Damage, HP, cooldowns, drop rates
- Energy / tickets that gate playtime
- Gate-clear skips, rank skips, win-rate
- A Resonance that is stronger than free ones (paid Resonances, if any, are identity + equal power budget)

**Ethics line:** If a whale and a free player enter the same grade gate, power is equal. Only look and convenience differ.

Slice 0: create `OfferDef` catalog + a debug button that “purchases” one cosmetic key skin. Do not wire real storefronts, receipts, or platform IAP plugins.

---

## 11. Engine conventions (non-negotiable)

- Godot 4.7+ stable. GDScript. Static types on every variable, parameter, return.
- Renderer: Compatibility (2D, desktop + future mobile).
- InputMap from day 1: `move_up/down/left/right`, `dash`, `attack`, `ability_1/2/3`, `rewrite`, `interact`, `pause`. Keyboard + gamepad both bound.
- One controller script per scene root. Cross-talk via EventBus signals, never brittle node paths.
- Systems never import Content. Content is Resource data consumed by id.
- All numbers live in `.tres` / custom Resources, not magic constants.
- Run state and meta state are **separate Resources**. Death/extract wipes `RunState`. `MetaState` persists to `user://`.
- Autoloads stay thin. No god object.
- Naming: folders and files `snake_case`, nodes `PascalCase`, `class_name` `PascalCase`, resources `snake_case.tres`.
- Placeholder visuals: `ColorRect` + `Label`. Readable. No asset hunt in session 1.

### Autoloads — exactly these five in slice 0

| Autoload | File | Job |
|---|---|---|
| `Events` | `autoload/events.gd` | Signals only |
| `App` | `autoload/app.gd` | Scene routing, settings, privacy flags, holds current MetaState + optional RunState |
| `SaveService` | `autoload/save_service.gd` | `user://` save/load |
| `AudioRouter` | `autoload/audio_router.gd` | Bus stubs |
| `ContentDB` | `autoload/content_db.gd` | Indexes `content/**/*.tres` by id |

Do not add more autoloads in slice 0.

---

## 12. Folder tree (create this first)

```
res://
  addons/
  assets/
    art/{characters,enemies,gates,hub,ui,vfx}
    audio/{sfx,music,ui}
    fonts/
  autoload/
    events.gd
    app.gd
    save_service.gd
    audio_router.gd
    content_db.gd
  content/
    resonances/
    abilities/
    talents/
    enemies/
    gates/
    items/
    story/
    economy/
  scenes/
    boot/boot.tscn
    ui/{title.tscn,hud.tscn,pause.tscn,results.tscn,talent_tree.tscn,shop.tscn,dialogue.tscn,association_desk.tscn}
    hub/hub.tscn
    gate/{gate_run.tscn,room.tscn,gate_entrance.tscn,extract_zone.tscn}
    actors/{player.tscn,enemy.tscn,npc.tscn,projectile.tscn}
    combat/{hitbox.tscn,hurtbox.tscn,damage_number.tscn}
  src/
    actors/
    combat/
    gate/
    meta/
    run/
    progression/
    economy/
    story/
    ui/
  resources_src/          # Resource scripts (class_name AbilityDef, etc.)
  DESIGN_DECISIONS.md
  README.md
```

---

## 13. Resource schemas to stub on day 1

Create a typed Resource script + at least one `.tres` instance for each:

- `AbilityDef` — id, display_name, tags:PackedStringArray, cooldown, key_charge_cost, is_rewrite, scene_path
- `ResonanceDef` — id, display_name, role, starting_ability_ids, talent_graph_id, unlocked
- `TalentNode` — id, track (Fang/Hide/Drift/Keywright), cost_essence, prereqs, modifiers, unlock_ability_id
- `TalentGraph` — id, resonance_id, nodes[]
- `GateTheme` — id, grade, hue, room_count, enemy_ids, boss_id, loot_table_id, law_pool_ids
- `GateLaw` — id, display_name, description, modifiers
- `EnemyDef` — id, display_name, hp, move_speed, telegraph_time, damage, scene_path
- `ItemDef` — id, slot, tags
- `LootTable` — id, entries[]
- `DialogueBeat` — id, speaker, lines[], requires_flags[], sets_flags[]
- `StoryBeat` — id, act, title, summary, implemented
- `OfferDef` — id, sku, kind (cosmetic/convenience), price_tier, grants
- `MetaState` — license, resonance_id, unlocked_talent_ids, essence, fragments, credits, aether_keys, canon, story_flags, cosmetic_ids
- `RunState` — seed, floor, rooms_cleared, key_charges, hp, run_loot, active_laws, rewrite_log

---

## 14. Rewrite verb (implement one, data-drive the rest)

Room controllers expose hooks:

- `seal_room` — spend 1 Key Charge, close a spawn portal mid-fight **(implement this)**
- `flip_hazard` — invert an environmental buff
- `reroute_exit` — force the next door
- `steal_law` — copy a Gate Law off an elite into the run
- `lock_exit` — freeze a door so nothing leaves (PvP later)

Slice 0 needs **Seal Room** wired to the `rewrite` input and a HUD charge counter. Other verbs can be stubs that print a Label.

---

## 15. First session — build this exact path

Work in this order. Do not skip to guilds, IAP receipts, or act 7.

0. `project.godot` with InputMap, display 1920×1080 (stretch), Compatibility renderer, five autoloads registered, folder tree created.
1. `Boot` → `Title` with Play / Options / Quit. Options: master/sfx/music sliders, language stub `en`, **Send crash reports = OFF**.
2. New-file flow: pick one of three Resonances. Write `MetaState.resonance_id`. Set `license = "unlisted"`. Grant starting Key Charges for the first run.
3. `Hub`: Association desk NPC (mentor one-liner), gate board listing one Fissure, talent shrine that is interactable but can be empty until after the first extract.
4. `Player` `CharacterBody2D`: 8-way move, dash with i-frames, basic attack hitbox, one Resonance skill, hurtbox, Key Charge counter.
5. `GateRun`: load `GateTheme`, seeded RNG, generate 3 rooms + boss room + extract zone.
6. One melee enemy with a telegraph wind-up. One boss that is a larger enemy plus a second attack.
7. Room-clear unlocks the door. Extract or death → `Results` (Essence, Fragments, Canon+1 if any rewrite was used, story line about the unmapped street).
8. Talent shrine reads `TalentGraph`, lets the player buy **one** node with Essence.
9. Quit → `SaveService` writes `user://riftwright_save.json` (or binary resource). Relaunch → talent and resonance still there.

### Slice 0 definition of done

From a cold F5:

Title → pick Resonance → Hub → enter Fissure → clear 3 rooms + boss (or die) → Results → spend 1 talent → Quit → Relaunch and the talent + Resonance persist.

Placeholder art is required, not optional. No multiplayer. No real IAP. No procedural city.

---

## 16. Do not build yet

- Live netcode, matchmaking, chat
- Real IAP plugins / receipts
- Procedural overworld / dungeon-break city map
- Voice, lip sync
- Localization files beyond `en`
- Analytics, crash-report upload
- Shadow / necromancy / monarch systems
- Full guild gameplay
- Acts 3–8 as playable content
- Mobile touch controls
- More than five autoloads

---

## 17. OPEN decisions (pick a default, log it, do not block)

- Final title
- City name
- Player origin job
- Final art style
- Target store (Steam / itch / mobile later)
- Whether paid Resonances ever exist (default: no)
- Whether Echo Duels ship before any live 1v1 (default: yes)
- Whether the Key has a second voice in slice 1 or only in story flags (default: flags only)

---

## 18. How to work in this conversation

**First response format (mandatory):**

1. Short confirmation: title, engine, hook in two sentences.
2. Create the folder tree, autoloads, Resource scripts, and `project.godot` settings.
3. Implement Title → Hub → Player movement as the first playable step.
4. List exactly which files you created.
5. End with the next 3 files you will build, then build them if context remains.

Rules:

- Prefer compiling scenes over describing them.
- If you must choose between more lore and a working dash, ship the dash.
- When adding a system, add the Resource schema first, then one instance, then the scene that consumes it.
- Keep comments scarce. Types and names should be enough.
- If something is OPEN, choose and write one line into `DESIGN_DECISIONS.md`.

Start now. Create the Godot project skeleton and the playable slice path. Do not write a second design document.
