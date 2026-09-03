class_name EchoLoadout
extends Resource

@export var player_name: String = ""
@export var resonance_id: String = ""
@export var hp: int = 100
@export var abilities: Array[String] = []
@export var talents: Array[String] = []
@export var standing: int = 0

func from_meta_state(meta: MetaState) -> void:
	if not meta:
		return
	resonance_id = meta.resonance_id
	abilities = []
	talents = meta.unlocked_talent_ids.duplicate()
	standing = meta.association_standing
	player_name = "Hunter_%d" % randi()
