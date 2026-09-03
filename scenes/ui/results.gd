extends Control

@onready var hp_label: Label = %HPLabel
@onready var key_charges_label: Label = %KeyChargesLabel
@onready var essence_label: Label = %EssenceLabel
@onready var fragments_label: Label = %FragmentsLabel
@onready var canon_label: Label = %CanonLabel
@onready var message_label: Label = %MessageLabel
@onready var return_button: Button = %ReturnButton

func _ready() -> void:
	return_button.pressed.connect(_on_return_pressed)
	_update_ui()

func _update_ui() -> void:
	if App.meta_state:
		essence_label.text = "Essence Gained: +20"
		fragments_label.text = "Fragments Gained: +5"
		
	if App.meta_state.canon > 0:
		canon_label.text = "Canon: %d (Reality remembers your edits)" % App.meta_state.canon
		message_label.text = "A mentor mentions: 'Strange... there's a street here that wasn't on the map this morning.'"
		_show_canon_dialogue()
	else:
		canon_label.text = ""
		message_label.text = "Gate cleared. Association retrieval confirmed."

func _show_canon_dialogue() -> void:
	if not App.meta_state.story_flags.has("canon_noticed"):
		var dialogue_scene: PackedScene = load("res://scenes/ui/dialogue.tscn")
		var dialogue: Control = dialogue_scene.instantiate()
		add_child(dialogue)
		dialogue.show_dialogue("first_extract")

func _on_return_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
