extends Node

var resonances: Dictionary = {}
var abilities: Dictionary = {}
var talents: Dictionary = {}
var enemies: Dictionary = {}
var gate_themes: Dictionary = {}
var items: Dictionary = {}
var dialogues: Dictionary = {}
var story_beats: Dictionary = {}

func _ready() -> void:
	_index_content()

func _index_content() -> void:
	_index_directory("res://content/resonances/", resonances)
	_index_directory("res://content/abilities/", abilities)
	_index_directory("res://content/talents/", talents)
	_index_directory("res://content/enemies/", enemies)
	_index_directory("res://content/gates/", gate_themes)
	_index_directory("res://content/items/", items)
	_index_directory("res://content/story/", story_beats)
	_index_dialogues()

func _index_directory(path: String, target_dict: Dictionary) -> void:
	var dir: DirAccess = DirAccess.open(path)
	if not dir:
		return
	
	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.ends_with(".tres"):
			var resource: Resource = load(path + file_name)
			if resource and resource.has_method("get_id"):
				target_dict[resource.get_id()] = resource
		file_name = dir.get_next()
	dir.list_dir_end()

func get_resonance(id: String) -> ResonanceDef:
	return resonances.get(id)

func get_ability(id: String) -> AbilityDef:
	return abilities.get(id)

func get_talent(id: String) -> TalentNode:
	return talents.get(id)

func get_enemy(id: String) -> EnemyDef:
	return enemies.get(id)

func get_gate_theme(id: String) -> GateTheme:
	return gate_themes.get(id)

func get_dialogue(id: String) -> DialogueBeat:
	return dialogues.get(id)

func _index_dialogues() -> void:
	var files: Array[String] = ["mentor_intro", "first_extract"]
	for file_id in files:
		var path: String = "res://content/story/dialogue_%s.tres" % file_id
		if ResourceLoader.exists(path):
			var resource: Resource = load(path)
			if resource and resource.has_method("get_id"):
				dialogues[resource.get_id()] = resource
