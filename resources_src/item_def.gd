class_name ItemDef
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var slot: String = ""
@export var tags: PackedStringArray = []

func get_id() -> String:
	return id
