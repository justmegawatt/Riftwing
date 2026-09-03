class_name EnemyDef
extends Resource

@export var id: String = ""
@export var display_name: String = ""
@export var hp: int = 30
@export var move_speed: float = 100.0
@export var telegraph_time: float = 0.5
@export var damage: int = 10
@export var attack_range: float = 50.0
@export var attack_cooldown: float = 2.0
@export var scene_path: String = "res://scenes/actors/enemy.tscn"

func get_id() -> String:
	return id
