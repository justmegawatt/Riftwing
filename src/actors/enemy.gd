extends CharacterBody2D

var enemy_def: EnemyDef
var hp: int = 30
var target: Node2D = null
var attack_timer: float = 0.0
var telegraph_timer: float = 0.0
var is_telegraphing: bool = false

@onready var sprite: ColorRect = $ColorRect
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	add_to_group("enemies")
	target = get_tree().get_first_node_in_group("player")

func setup(def: EnemyDef) -> void:
	enemy_def = def
	hp = def.hp

func _physics_process(delta: float) -> void:
	if not target or not enemy_def:
		return
	
	var distance_to_target: float = global_position.distance_to(target.global_position)
	
	if is_telegraphing:
		telegraph_timer -= delta
		if telegraph_timer <= 0.0:
			is_telegraphing = false
			_execute_attack()
	elif attack_timer > 0.0:
		attack_timer -= delta
	elif distance_to_target <= enemy_def.attack_range:
		_start_telegraph()
	else:
		var direction: Vector2 = (target.global_position - global_position).normalized()
		velocity = direction * enemy_def.move_speed
		move_and_slide()

func _start_telegraph() -> void:
	is_telegraphing = true
	telegraph_timer = enemy_def.telegraph_time
	sprite.color = Color.ORANGE

func _execute_attack() -> void:
	attack_timer = enemy_def.attack_cooldown
	sprite.color = Color.RED
	
	if target and global_position.distance_to(target.global_position) <= enemy_def.attack_range:
		if target.has_method("take_damage"):
			target.take_damage(enemy_def.damage)
	
	await get_tree().create_timer(0.2).timeout
	if is_instance_valid(self):
		sprite.color = Color.DARK_RED

func take_damage(amount: int) -> void:
	hp -= amount
	if hp <= 0:
		die()

func die() -> void:
	Events.enemy_died.emit(enemy_def.id if enemy_def else "unknown")
	queue_free()
