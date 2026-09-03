class_name RunState
extends Resource

var seed: int = 0
var floor: int = 1
var rooms_cleared: int = 0
var key_charges: int = 3
var hp: int = 100
var max_hp: int = 100
var run_loot: Array = []
var active_laws: Array[String] = []
var rewrite_log: Array[String] = []
var gate_theme_id: String = ""
