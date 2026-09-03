extends Node

var meta_state: MetaState = null
var run_state: RunState = null

var master_volume: float = 1.0
var sfx_volume: float = 1.0
var music_volume: float = 1.0
var send_crash_reports: bool = false
var language: String = "en"

func _ready() -> void:
	randomize()

func start_new_game() -> void:
	meta_state = MetaState.new()
	meta_state.license = "unlisted"
	meta_state.essence = 0
	meta_state.fragments = 0
	meta_state.credits = 0
	meta_state.aether_keys = 0
	meta_state.canon = 0
	meta_state.story_flags = []
	meta_state.unlocked_talent_ids = []
	meta_state.cosmetic_ids = []

func start_gate_run(gate_theme_id: String) -> void:
	run_state = RunState.new()
	run_state.seed = randi()
	run_state.floor = 1
	run_state.rooms_cleared = 0
	run_state.key_charges = 3
	run_state.hp = 100
	run_state.max_hp = 100
	run_state.run_loot = []
	run_state.active_laws = []
	run_state.rewrite_log = []
	run_state.gate_theme_id = gate_theme_id
	Events.gate_entered.emit(gate_theme_id)

func end_gate_run(extracted: bool) -> void:
	if extracted:
		Events.gate_extracted.emit()
	else:
		Events.gate_failed.emit()

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
