extends Node2D

var gate_theme: GateTheme
var current_room: int = 0
var enemies_in_room: int = 0
var room_cleared: bool = false

@onready var player: CharacterBody2D = $Player
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	if not App.run_state:
		App.start_gate_run("fissure_01")
	
	gate_theme = ContentDB.get_gate_theme(App.run_state.gate_theme_id)
	if not gate_theme:
		push_error("Gate theme not found")
		return
	
	camera.position = Vector2(960, 540)
	
	Events.enemy_died.connect(_on_enemy_died)
	
	_update_background_color()
	_generate_room()

func _update_background_color() -> void:
	if gate_theme and has_node("Background"):
		var bg: Sprite2D = $Background
		bg.modulate = gate_theme.hue

func _generate_room() -> void:
	room_cleared = false
	current_room += 1
	
	var is_boss_room: bool = current_room > gate_theme.room_count
	
	if is_boss_room:
		_spawn_boss()
	else:
		_spawn_enemies()

func _spawn_enemies() -> void:
	var min_enemies: int = 2 + int(current_room * 0.5)
	var max_enemies: int = 3 + current_room
	enemies_in_room = randi_range(min_enemies, max_enemies)
	
	for i in range(enemies_in_room):
		var enemy_scene: PackedScene = load("res://scenes/actors/enemy.tscn")
		var enemy: CharacterBody2D = enemy_scene.instantiate()
		
		var spawn_pos: Vector2 = Vector2(
			randf_range(400, 1520),
			randf_range(200, 880)
		)
		enemy.global_position = spawn_pos
		
		var enemy_id: String = gate_theme.enemy_ids[randi() % gate_theme.enemy_ids.size()]
		var enemy_def: EnemyDef = ContentDB.get_enemy(enemy_id)
		if enemy_def:
			enemy.setup(enemy_def)
		
		add_child(enemy)

func _spawn_boss() -> void:
	enemies_in_room = 1
	
	var enemy_scene: PackedScene = load("res://scenes/actors/enemy.tscn")
	var boss: CharacterBody2D = enemy_scene.instantiate()
	boss.global_position = Vector2(960, 540)
	
	var boss_def: EnemyDef = ContentDB.get_enemy(gate_theme.boss_id)
	if boss_def:
		boss.setup(boss_def)
	
	add_child(boss)

func _on_enemy_died(enemy_id: String) -> void:
	enemies_in_room -= 1
	
	if App.run_state:
		App.run_state.rooms_cleared += 1
	
	if enemies_in_room <= 0:
		_on_room_cleared()

func _on_room_cleared() -> void:
	room_cleared = true
	Events.room_cleared.emit()
	
	var is_final_room: bool = current_room > gate_theme.room_count
	
	if is_final_room:
		await get_tree().create_timer(1.0).timeout
		_extract()
	else:
		await get_tree().create_timer(2.0).timeout
		_clear_enemies()
		_generate_room()

func _clear_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()

func _extract() -> void:
	var base_essence: int = 15
	var base_fragments: int = 3
	
	var grade_multiplier: float = 1.0
	match gate_theme.grade:
		"Breach": grade_multiplier = 1.5
		"Rift": grade_multiplier = 2.0
		"Sovereign Rift": grade_multiplier = 3.0
		"Black Gate": grade_multiplier = 5.0
	
	var essence_reward: int = int(base_essence * grade_multiplier * (1.0 + current_room * 0.1))
	var fragments_reward: int = int(base_fragments * grade_multiplier)
	
	App.meta_state.essence += essence_reward
	App.meta_state.fragments += fragments_reward
	App.meta_state.association_standing += int(grade_multiplier * 10)
	
	if App.run_state.rewrite_log.size() > 0:
		App.meta_state.canon += 1
	
	if not App.meta_state.gates_cleared.has(gate_theme.id):
		App.meta_state.gates_cleared[gate_theme.id] = 0
	App.meta_state.gates_cleared[gate_theme.id] += 1
	
	_unlock_next_gate()
	
	Events.essence_changed.emit(essence_reward)
	Events.fragments_changed.emit(fragments_reward)
	
	App.end_gate_run(true)
	SaveService.save_game()
	App.change_scene("res://scenes/ui/results.tscn")

func _unlock_next_gate() -> void:
	var gate_progression: Array[String] = [
		"fissure_01",
		"breach_01",
		"rift_01",
		"sovereign_rift_01",
		"black_gate_01"
	]
	
	var current_index: int = gate_progression.find(gate_theme.id)
	if current_index >= 0 and current_index < gate_progression.size() - 1:
		var next_gate: String = gate_progression[current_index + 1]
		if not App.meta_state.unlocked_gate_ids.has(next_gate):
			var cleared_current: int = App.meta_state.gates_cleared.get(gate_theme.id, 0)
			if cleared_current >= 2:
				App.meta_state.unlocked_gate_ids.append(next_gate)
	
	_unlock_advanced_resonances()

func _unlock_advanced_resonances() -> void:
	var total_gates_cleared: int = 0
	for count in App.meta_state.gates_cleared.values():
		total_gates_cleared += count
	
	if total_gates_cleared >= 5 and not App.meta_state.unlocked_resonance_ids.has("nightthread"):
		App.meta_state.unlocked_resonance_ids.append("nightthread")
		Events.resonance_unlocked.emit("nightthread")
	
	if total_gates_cleared >= 10 and not App.meta_state.unlocked_resonance_ids.has("bindscript"):
		App.meta_state.unlocked_resonance_ids.append("bindscript")
		Events.resonance_unlocked.emit("bindscript")
	
	if total_gates_cleared >= 15 and not App.meta_state.unlocked_resonance_ids.has("heartwell"):
		App.meta_state.unlocked_resonance_ids.append("heartwell")
		Events.resonance_unlocked.emit("heartwell")
