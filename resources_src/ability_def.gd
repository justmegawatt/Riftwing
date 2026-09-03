class_name AbilityDef
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var tags: PackedStringArray = []
@export var cooldown: float = 0.0
@export var key_charge_cost: int = 0
@export var is_rewrite: bool = false
@export var damage: int = 10
@export var range: float = 100.0
@export var scene_path: String = ""

func get_id() -> String:
	return id
