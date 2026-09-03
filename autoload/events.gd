extends Node

signal player_damaged(amount: int)
signal player_healed(amount: int)
signal player_died()
signal enemy_died(enemy_id: String)

signal room_cleared()
signal gate_entered(theme_id: String)
signal gate_extracted()
signal gate_failed()

signal key_charge_spent(amount: int)
signal key_charge_gained(amount: int)

signal talent_unlocked(talent_id: String)
signal resonance_selected(resonance_id: String)

signal ability_used(ability_id: String)
signal rewrite_triggered(verb: String, target: Node)

signal essence_changed(amount: int)
signal fragments_changed(amount: int)
signal canon_changed(amount: int)
