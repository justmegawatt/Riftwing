extends Control

@onready var striker_button: Button = %StrikerButton
@onready var warden_button: Button = %WardenButton
@onready var hexer_button: Button = %HexerButton

func _ready() -> void:
	striker_button.pressed.connect(_on_resonance_selected.bind("striker"))
	warden_button.pressed.connect(_on_resonance_selected.bind("warden"))
	hexer_button.pressed.connect(_on_resonance_selected.bind("hexer"))

func _on_resonance_selected(resonance_id: String) -> void:
	App.start_new_game()
	App.meta_state.resonance_id = resonance_id
	Events.resonance_selected.emit(resonance_id)
	SaveService.save_game()
	App.change_scene("res://scenes/hub/hub.tscn")
