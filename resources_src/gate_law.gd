class_name GateLaw
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var description: String = ""
@export var modifiers: Dictionary = {}

func get_id() -> String:
	return id
