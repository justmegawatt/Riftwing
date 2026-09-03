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

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	if App.run_state:
		hp = App.run_state.hp
		max_hp = App.run_state.max_hp
	hurtbox.area_entered.connect(_on_hurtbox_area_entered)
	_update_sprite_for_resonance()

func _update_sprite_for_resonance() -> void:
	if not App.meta_state:
		return
	
	var texture_path: String = ""
	match App.meta_state.resonance_id:
		"striker":
			texture_path = "res://assets/art/characters/striker_idle.png"
		"warden":
			texture_path = "res://assets/art/characters/warden_idle.png"
		"hexer":
			texture_path = "res://assets/art/characters/hexer_idle.png"
		"nightthread", "bindscript", "heartwell":
			texture_path = "res://assets/art/characters/striker_idle.png"
	
	if texture_path != "" and ResourceLoader.exists(texture_path):
		sprite.texture = load(texture_path)
		
		if App.meta_state.resonance_id in ["nightthread", "bindscript", "heartwell"]:
			sprite.modulate = Color(0.8, 0.6, 1.2)

func _physics_process(delta: float) -> void:
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			is_invulnerable = false
			sprite.modulate = Color.WHITE
		else:
			velocity = dash_direction * DASH_SPEED
			sprite.modulate = Color(1, 1, 1, 0.5)
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
	sprite.modulate = Color(1.5, 1.5, 1.5)
	await get_tree().create_timer(0.1).timeout
	if is_instance_valid(self):
		sprite.modulate = Color.WHITE
	
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
	
	sprite.modulate = Color(2, 2, 0.5)
	await get_tree().create_timer(0.15).timeout
	if is_instance_valid(self):
		sprite.modulate = Color.WHITE if App.meta_state.resonance_id not in ["nightthread", "bindscript", "heartwell"] else Color(0.8, 0.6, 1.2)
	
	if ability.damage < 0:
		hp = mini(hp - ability.damage, max_hp)
		if App.run_state:
			App.run_state.hp = hp
		Events.player_healed.emit(-ability.damage)
		return
	
	var enemies: Array = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if global_position.distance_to(enemy.global_position) < ability.range:
			if enemy.has_method("take_damage"):
				enemy.take_damage(ability.damage)

func _perform_rewrite() -> void:
	if not App.run_state:
		return
	
	App.run_state.key_charges -= 1
	App.run_state.rewrite_log.append("seal_room")
	Events.key_charge_spent.emit(1)
	Events.rewrite_triggered.emit("seal_room", null)
	
	sprite.modulate = Color(1.5, 0.5, 2)
	await get_tree().create_timer(0.2).timeout
	if is_instance_valid(self):
		sprite.modulate = Color.WHITE
	
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
	
	sprite.modulate = Color(2, 0.5, 0.5)
	await get_tree().create_timer(0.1).timeout
	if is_instance_valid(self):
		sprite.modulate = Color.WHITE
	
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
