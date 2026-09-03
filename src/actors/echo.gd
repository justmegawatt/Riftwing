extends CharacterBody2D

var echo_loadout: EchoLoadout
var hp: int = 100
var target: Node2D = null
var attack_timer: float = 0.0

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("echo_enemy")
	target = get_tree().get_first_node_in_group("player")
	if echo_loadout:
		_apply_loadout()

func setup_echo(loadout: EchoLoadout) -> void:
	echo_loadout = loadout
	if echo_loadout:
		hp = echo_loadout.hp
		_apply_loadout()

func _apply_loadout() -> void:
	if ResourceLoader.exists("res://assets/art/characters/striker_idle.png"):
		sprite.texture = load("res://assets/art/characters/striker_idle.png")
		sprite.modulate = Color(1, 0.5, 0.8)

func _physics_process(delta: float) -> void:
	if not target:
		return
	
	var distance_to_target: float = global_position.distance_to(target.global_position)
	
	if attack_timer > 0.0:
		attack_timer -= delta
	elif distance_to_target <= 100.0:
		_perform_attack()
	else:
		var direction: Vector2 = (target.global_position - global_position).normalized()
		velocity = direction * 150.0
		move_and_slide()

func _perform_attack() -> void:
	attack_timer = 2.0
	sprite.modulate = Color(2, 0.5, 0.8)
	
	if target and global_position.distance_to(target.global_position) <= 100.0:
		if target.has_method("take_damage"):
			target.take_damage(20)
	
	await get_tree().create_timer(0.2).timeout
	if is_instance_valid(self):
		sprite.modulate = Color(1, 0.5, 0.8)

func take_damage(amount: int) -> void:
	hp -= amount
	sprite.modulate = Color(1.5, 1.5, 1.5)
	await get_tree().create_timer(0.05).timeout
	if is_instance_valid(self):
		sprite.modulate = Color(1, 0.5, 0.8)
	
	if hp <= 0:
		die()

func die() -> void:
	if App.meta_state:
		App.meta_state.essence += 40
		App.meta_state.association_standing += 25
	queue_free()
