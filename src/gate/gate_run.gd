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
	
	_generate_room()

func _generate_room() -> void:
	room_cleared = false
	current_room += 1
	
	var is_boss_room: bool = current_room > gate_theme.room_count
	
	if is_boss_room:
		_spawn_boss()
	else:
		_spawn_enemies()

func _spawn_enemies() -> void:
	enemies_in_room = randi_range(2, 4)
	
	for i in range(enemies_in_room):
		var enemy_scene: PackedScene = load("res://scenes/actors/enemy.tscn")
		var enemy: CharacterBody2D = enemy_scene.instantiate()
		
		var spawn_pos: Vector2 = Vector2(
			randf_range(400, 1520),
			randf_range(200, 880)
		)
		enemy.global_position = spawn_pos
		
		var enemy_def: EnemyDef = ContentDB.get_enemy(gate_theme.enemy_ids[0])
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
	App.meta_state.essence += 20
	App.meta_state.fragments += 5
	if App.run_state.rewrite_log.size() > 0:
		App.meta_state.canon += 1
	
	Events.essence_changed.emit(20)
	Events.fragments_changed.emit(5)
	
	App.end_gate_run(true)
	SaveService.save_game()
	App.change_scene("res://scenes/ui/results.tscn")
