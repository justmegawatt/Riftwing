extends Node

var resonances: Dictionary = {}
var abilities: Dictionary = {}
var talents: Dictionary = {}
var enemies: Dictionary = {}
var gate_themes: Dictionary = {}
var items: Dictionary = {}

func _ready() -> void:
	_index_content()

func _index_content() -> void:
	_index_directory("res://content/resonances/", resonances)
	_index_directory("res://content/abilities/", abilities)
	_index_directory("res://content/talents/", talents)
	_index_directory("res://content/enemies/", enemies)
	_index_directory("res://content/gates/", gate_themes)
	_index_directory("res://content/items/", items)

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
