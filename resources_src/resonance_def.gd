class_name ResonanceDef
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var role: String = ""
@export var starting_ability_ids: PackedStringArray = []
@export var talent_graph_id: String = ""
@export var unlocked: bool = true
@export var description: String = ""

func get_id() -> String:
	return id
