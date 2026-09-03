extends CharacterBody2D

const SPEED: float = 300.0
const DASH_SPEED: float = 800.0
const DASH_DURATION: float = 0.2

var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_direction: Vector2 = Vector2.ZERO
var is_invulnerable: bool = false

var hp: int = 100
var max_hp: int = 100

var attack_cooldown: float = 0.0
var ability_cooldown: float = 0.0

@onready var sprite: ColorRect = $ColorRect
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	if App.run_state:
		hp = App.run_state.hp
		max_hp = App.run_state.max_hp
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)

func _physics_process(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			is_invulnerable = false
		else:
			velocity = dash_direction * DASH_SPEED
	else:
		var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_dir * SPEED
		
		if Input.is_action_just_pressed("dash") and input_dir.length() > 0:
			_start_dash(input_dir.normalized())
	
	move_and_slide()
	
	attack_cooldown -= delta
	ability_cooldown -= delta
	
	if Input.is_action_just_pressed("attack") and attack_cooldown <= 0.0:
		_perform_attack()
	
	if Input.is_action_just_pressed("ability_1") and ability_cooldown <= 0.0:
		_perform_ability()
	
	if Input.is_action_just_pressed("rewrite") and App.run_state and App.run_state.key_charges > 0:
		_perform_rewrite()

func _start_dash(direction: Vector2) -> void:
	is_dashing = true
	is_invulnerable = true
	dash_timer = DASH_DURATION
	dash_direction = direction

func _perform_attack() -> void:
	attack_cooldown = 0.5
	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) < 100.0:
			if enemy.has_method("take_damage"):
				enemy.take_damage(20)

func _perform_ability() -> void:
	if not App.meta_state:
		return
	
	var resonance: ResonanceDef = ContentDB.get_resonance(App.meta_state.resonance_id)
	if not resonance or resonance.starting_ability_ids.size() == 0:
		return
	
	var ability_id: String = resonance.starting_ability_ids[0]
	var ability: AbilityDef = ContentDB.get_ability(ability_id)
	if not ability:
		return
	
	ability_cooldown = ability.cooldown
	Events.ability_used.emit(ability_id)
	
	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) < ability.range:
			if enemy.has_method("take_damage"):
				enemy.take_damage(ability.damage)

func _perform_rewrite() -> void:
	if not App.run_state:
		return
	
	App.run_state.key_charges -= 1
	Events.key_charge_spent.emit(1)
	Events.rewrite_triggered.emit("seal_room", null)
	
	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	if enemies.size() > 0:
		var enemy: Node = enemies[0]
		enemy.queue_free()

func take_damage(amount: int) -> void:
	if is_invulnerable:
		return
	
	hp -= amount
	if App.run_state:
		App.run_state.hp = hp
	
	Events.player_damaged.emit(amount)
	
	if hp <= 0:
		die()

func die() -> void:
	Events.player_died.emit()
	App.end_gate_run(false)
	App.change_scene("res://scenes/ui/results.tscn")

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_hitbox"):
		var damage: int = 10
		if area.has_method("get_damage"):
			damage = area.get_damage()
		take_damage(damage)
