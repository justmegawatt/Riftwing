extends Control

@onready var gate_board: VBoxContainer = %GateBoard
@onready var gate_list_container: VBoxContainer = %GateListContainer
@onready var talent_button: Button = %TalentButton
@onready var shop_button: Button = %ShopButton
@onready var codex_button: Button = %CodexButton

func _ready() -> void:
	talent_button.pressed.connect(_on_talent_pressed)
	shop_button.pressed.connect(_on_shop_pressed)
	codex_button.pressed.connect(_on_codex_pressed)
	_update_ui()

func _update_ui() -> void:
	if App.meta_state:
		var resonance: ResonanceDef = ContentDB.get_resonance(App.meta_state.resonance_id)
		if resonance:
			%ResonanceLabel.text = resonance.display_name
		%EssenceLabel.text = "Essence: %d" % App.meta_state.essence
		%FragmentsLabel.text = "Fragments: %d" % App.meta_state.fragments
		%CanonLabel.text = "Canon: %d" % App.meta_state.canon
		
		_populate_gate_list()

func _populate_gate_list() -> void:
	for child in gate_list_container.get_children():
		child.queue_free()
	
	if not App.meta_state:
		return
	
	for gate_id in App.meta_state.unlocked_gate_ids:
		var gate_theme: GateTheme = ContentDB.get_gate_theme(gate_id)
		if not gate_theme:
			continue
		
		var button: Button = Button.new()
		var cleared_count: int = App.meta_state.gates_cleared.get(gate_id, 0)
		button.text = "%s - %s\nRooms: %d | Cleared: %d times" % [gate_theme.grade, gate_theme.id, gate_theme.room_count + 1, cleared_count]
		button.theme_override_font_sizes["font_size"] = 16
		button.pressed.connect(_on_gate_selected.bind(gate_id))
		gate_list_container.add_child(button)

func _on_gate_selected(gate_id: String) -> void:
	App.start_gate_run(gate_id)
	App.change_scene("res://scenes/gate/gate_run.tscn")

func _on_talent_pressed() -> void:
	App.change_scene("res://scenes/ui/talent_tree.tscn")

func _on_shop_pressed() -> void:
	App.change_scene("res://scenes/ui/shop.tscn")

func _on_codex_pressed() -> void:
	App.change_scene("res://scenes/ui/gate_codex.tscn")
