class_name DialogueBeat
extends Resource

@export var id: String = ""
@export var speaker: String = ""
@export var lines: PackedStringArray = []
@export var requires_flags: PackedStringArray = []
@export var sets_flags: PackedStringArray = []

func get_id() -> String:
	return id
