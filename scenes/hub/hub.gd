extends Control

@onready var gate_board: VBoxContainer = %GateBoard
@onready var enter_gate_button: Button = %EnterGateButton
@onready var talent_button: Button = %TalentButton

func _ready() -> void:
	enter_gate_button.pressed.connect(_on_enter_gate_pressed)
	talent_button.pressed.connect(_on_talent_pressed)
	_update_ui()

func _update_ui() -> void:
	if App.meta_state:
		var resonance: ResonanceDef = ContentDB.get_resonance(App.meta_state.resonance_id)
		if resonance:
			%ResonanceLabel.text = resonance.display_name
		%EssenceLabel.text = "Essence: %d" % App.meta_state.essence
		%FragmentsLabel.text = "Fragments: %d" % App.meta_state.fragments
		%CanonLabel.text = "Canon: %d" % App.meta_state.canon

func _on_enter_gate_pressed() -> void:
	App.start_gate_run("fissure_01")
	App.change_scene("res://scenes/gate/gate_run.tscn")

func _on_talent_pressed() -> void:
	App.change_scene("res://scenes/ui/talent_tree.tscn")
