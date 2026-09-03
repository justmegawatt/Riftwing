extends Control

@onready var laws_list: VBoxContainer = %LawsList
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	_populate_codex()

func _populate_codex() -> void:
	if not App.meta_state:
		return
	
	for child in laws_list.get_children():
		child.queue_free()
	
	if App.meta_state.stolen_laws.size() == 0:
		var label: Label = Label.new()
		label.text = "No Gate Laws stolen yet. Use Steal Law rewrite on elite enemies."
		label.theme_override_font_sizes["font_size"] = 16
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		laws_list.add_child(label)
		return
	
	for law_id in App.meta_state.stolen_laws:
		var panel: PanelContainer = PanelContainer.new()
		var vbox: VBoxContainer = VBoxContainer.new()
		
		var title_label: Label = Label.new()
		title_label.text = "Gate Law: %s" % law_id
		title_label.theme_override_font_sizes["font_size"] = 18
		vbox.add_child(title_label)
		
		var desc_label: Label = Label.new()
		desc_label.text = "A rewritten rule extracted from the gate. Reality remembers."
		desc_label.theme_override_font_sizes["font_size"] = 14
		desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		vbox.add_child(desc_label)
		
		panel.add_child(vbox)
		laws_list.add_child(panel)

func _on_back_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
