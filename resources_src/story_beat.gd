class_name StoryBeat
extends Resource

@export var id: String = ""
@export var act: int = 1
@export var title: String = ""
@export var summary: String = ""
@export var implemented: bool = false

func get_id() -> String:
	return id
