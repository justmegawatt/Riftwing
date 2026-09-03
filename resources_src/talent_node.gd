class_name TalentNode
extends Resource

@export var id: String = ""
@export var track: String = ""
@export var cost_essence: int = 10
@export var prereqs: PackedStringArray = []
@export var modifiers: Dictionary = {}
@export var unlock_ability_id: String = ""
@export var display_name: String = ""
@export var description: String = ""

func get_id() -> String:
	return id
