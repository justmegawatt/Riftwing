extends Control

@onready var striker_button: Button = %StrikerButton
@onready var warden_button: Button = %WardenButton
@onready var hexer_button: Button = %HexerButton
@onready var nightthread_button: Button = %NightthreadButton
@onready var bindscript_button: Button = %BindscriptButton
@onready var heartwell_button: Button = %HeartwellButton

func _ready() -> void:
	striker_button.pressed.connect(_on_resonance_selected.bind("striker"))
	warden_button.pressed.connect(_on_resonance_selected.bind("warden"))
	hexer_button.pressed.connect(_on_resonance_selected.bind("hexer"))
	nightthread_button.pressed.connect(_on_resonance_selected.bind("nightthread"))
	bindscript_button.pressed.connect(_on_resonance_selected.bind("bindscript"))
	heartwell_button.pressed.connect(_on_resonance_selected.bind("heartwell"))
	
	_check_locked_resonances()

func _check_locked_resonances() -> void:
	var unlocked: Array[String] = ["striker", "warden", "hexer"]
	
	if SaveService.load_game() and App.meta_state:
		unlocked = App.meta_state.unlocked_resonance_ids
	
	nightthread_button.disabled = not unlocked.has("nightthread")
	bindscript_button.disabled = not unlocked.has("bindscript")
	heartwell_button.disabled = not unlocked.has("heartwell")
	
	if nightthread_button.disabled:
		nightthread_button.text += " [LOCKED]"
	if bindscript_button.disabled:
		bindscript_button.text += " [LOCKED]"
	if heartwell_button.disabled:
		heartwell_button.text += " [LOCKED]"

func _on_resonance_selected(resonance_id: String) -> void:
	if not App.meta_state:
		App.start_new_game()
	
	App.meta_state.resonance_id = resonance_id
	Events.resonance_selected.emit(resonance_id)
	SaveService.save_game()
	App.change_scene("res://scenes/hub/hub.tscn")
