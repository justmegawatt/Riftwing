extends Node

const SAVE_PATH: String = "user://riftwright_save.json"

func save_game() -> void:
	if App.meta_state == null:
		return
	
	var save_dict: Dictionary = {
		"license": App.meta_state.license,
		"resonance_id": App.meta_state.resonance_id,
		"unlocked_talent_ids": App.meta_state.unlocked_talent_ids,
		"essence": App.meta_state.essence,
		"fragments": App.meta_state.fragments,
		"credits": App.meta_state.credits,
		"aether_keys": App.meta_state.aether_keys,
		"canon": App.meta_state.canon,
		"story_flags": App.meta_state.story_flags,
		"cosmetic_ids": App.meta_state.cosmetic_ids,
	}
	
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_dict, "\t"))
		file.close()

func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return false
	
	var json_string: String = file.get_as_text()
	file.close()
	
	var json: JSON = JSON.new()
	var parse_result: Error = json.parse(json_string)
	if parse_result != OK:
		return false
	
	var save_dict: Dictionary = json.data
	
	App.meta_state = MetaState.new()
	App.meta_state.license = save_dict.get("license", "unlisted")
	App.meta_state.resonance_id = save_dict.get("resonance_id", "")
	App.meta_state.unlocked_talent_ids = save_dict.get("unlocked_talent_ids", [])
	App.meta_state.essence = save_dict.get("essence", 0)
	App.meta_state.fragments = save_dict.get("fragments", 0)
	App.meta_state.credits = save_dict.get("credits", 0)
	App.meta_state.aether_keys = save_dict.get("aether_keys", 0)
	App.meta_state.canon = save_dict.get("canon", 0)
	App.meta_state.story_flags = save_dict.get("story_flags", [])
	App.meta_state.cosmetic_ids = save_dict.get("cosmetic_ids", [])
	
	return true
