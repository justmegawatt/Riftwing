class_name TalentGraph
extends Resource

@export var id: String = ""
@export var resonance_id: String = ""
@export var nodes: Array[TalentNode] = []

func get_id() -> String:
	return id
