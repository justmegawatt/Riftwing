# Design Decisions Log

This document records OPEN design choices made during initial implementation.

## Decisions Made

### 1. Final Title
**Default:** Riftwright
**Alternatives considered:** Gatewright, Unlicensed, Riftbound, Unlisted, Keybearer
**Rationale:** "Riftwright" emphasizes the craft of editing/authoring gates, distinct from generic "gate" games.

### 2. City Name
**Default:** Unnamed in slice 0
**Future:** Will be a fictionalized Seoul-ish megacity, name TBD based on localization needs.

### 3. Player Origin
**Default:** Rescue volunteer / Association-adjacent civilian
**Alternatives:** Clerk, Paramedic, Delinquent, Failed academy cadet, Foreign student
**Rationale:** Civilian origin makes the Key acquisition more dramatic. Can be made selectable later.

### 4. Art Style
**Current:** Placeholder ColorRects with high-contrast colors
**Future:** OPEN - could be pixel art, painterly manhwa style, or vector. Requires readable telegraphs and silhouettes.

### 5. Target Store
**Default:** Desktop-first, platform TBD
**Options:** Steam, itch.io, later mobile
**Rationale:** Focus on keyboard+mouse+gamepad for v1, add touch later as a skin.

### 6. Paid Resonances
**Default:** No paid Resonances
**Rationale:** All Resonances should be earnable. Paid cosmetics for Resonances (VFX skins) are OK, but never power.

### 7. Echo Duels vs Live PvP
**Default:** Echo Duels (async) ship before live 1v1
**Rationale:** Simpler to implement, no netcode needed for v1, still delivers competitive experience.

### 8. Key Voice
**Default:** Key communicates via story flags only in slice 0
**Future:** May add second voice in dialogue later (act 6+).

### 9. License Progression
**Default:** Player starts Unlisted, offered Bronze License by Association
**Progression:** Unlisted → Provisional → Bronze → Silver → Gold → Black File
**Rationale:** Association wants to control Keywrights. License is political, not power.

### 10. Gate Run Length
**Default:** 3 rooms + boss + extract for slice 0
**Target:** 12-20 minutes for full runs in later versions
**Rationale:** Short enough for lunch-break play, long enough for meaningful decisions.

### 11. Rewrite Implementation Order
**Default:** "Seal Room" implemented first
**Future:** Flip hazard, reroute exit, steal law, lock exit as later unlocks
**Rationale:** Seal Room is the clearest verb, demonstrates Key Charges immediately.

### 12. Dash I-frames
**Default:** 0.2 second dash with full invulnerability
**Rationale:** Hades-like action cadence. Rewards precise timing.

### 13. Camera
**Default:** Fixed camera at center of 1920x1080 arena
**Future:** Could follow player or room-locked camera for procedural layouts
**Rationale:** Simplest for slice 0 single-room combat arenas.

### 14. Enemy Telegraphs
**Default:** Color change (RED = attacking, ORANGE = telegraphing)
**Future:** VFX particles, screen shake, sound cues
**Rationale:** Placeholder must be readable. Color is sufficient for slice 0.

### 15. Save Format
**Default:** JSON at user://riftwright_save.json
**Alternative:** Binary .res or encrypted
**Rationale:** Human-readable for debugging. Can encrypt later if needed.

---

**Note:** These are defaults chosen to avoid blocking development. All are open to revision based on playtesting and user feedback.
