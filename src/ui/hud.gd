extends CanvasLayer

@onready var hp_label: Label = $MarginContainer/VBoxContainer/HPLabel
@onready var key_charges_label: Label = $MarginContainer/VBoxContainer/KeyChargesLabel
@onready var room_label: Label = $MarginContainer/VBoxContainer/RoomLabel

func _ready() -> void:
	Events.player_damaged.connect(_update_hp)
	Events.key_charge_spent.connect(_update_key_charges)
	Events.room_cleared.connect(_update_room)
	_update_all()

func _update_all() -> void:
	_update_hp()
	_update_key_charges()
	_update_room()

func _update_hp(_amount: int = 0) -> void:
	if App.run_state:
		hp_label.text = "HP: %d/%d" % [App.run_state.hp, App.run_state.max_hp]

func _update_key_charges(_amount: int = 0) -> void:
	if App.run_state:
		key_charges_label.text = "Key Charges: %d" % App.run_state.key_charges

func _update_room() -> void:
	var gate_run: Node = get_parent()
	if gate_run and gate_run.has("current_room") and gate_run.has("gate_theme"):
		var theme: GateTheme = gate_run.gate_theme
		if theme:
			room_label.text = "Room: %d/%d" % [gate_run.current_room, theme.room_count + 1]
