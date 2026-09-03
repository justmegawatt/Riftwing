class_name GateTheme
extends Resource

@export var id: String = ""
@export var grade: String = "Fissure"
@export var hue: Color = Color.RED
@export var room_count: int = 3
@export var enemy_ids: PackedStringArray = []
@export var boss_id: String = ""
@export var loot_table_id: String = ""
@export var law_pool_ids: PackedStringArray = []

func get_id() -> String:
	return id
