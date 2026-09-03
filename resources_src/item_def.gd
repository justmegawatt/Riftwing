class_name ItemDef
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var slot: String = "relic"
@export var tags: PackedStringArray = []
@export var modifiers: Dictionary = {}

func get_id() -> String:
	return id
