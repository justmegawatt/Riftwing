extends Control

@onready var cosmetic_list: VBoxContainer = %CosmeticList
@onready var back_button: Button = %BackButton
@onready var aether_keys_label: Label = %AetherKeysLabel

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	_populate_cosmetics()

func _populate_cosmetics() -> void:
	if not App.meta_state:
		return
	
	aether_keys_label.text = "Aether Keys: %d" % App.meta_state.aether_keys
	
	for child in cosmetic_list.get_children():
		child.queue_free()
	
	var cosmetics: Array[Dictionary] = [
		{"name": "Silver Key Skin", "price": 100, "type": "key_skin", "id": "key_skin_silver"},
		{"name": "Void Aura", "price": 250, "type": "aura", "id": "aura_void"},
		{"name": "Crimson Weapon Trail", "price": 150, "type": "weapon_skin", "id": "weapon_crimson"},
		{"name": "Hub Apartment: Penthouse", "price": 500, "type": "hub_apartment", "id": "apartment_penthouse"},
		{"name": "Talent Respec Token", "price": 75, "type": "convenience", "id": "respec_token"},
	]
	
	for cosmetic in cosmetics:
		var panel: PanelContainer = PanelContainer.new()
		var hbox: HBoxContainer = HBoxContainer.new()
		
		var vbox: VBoxContainer = VBoxContainer.new()
		var name_label: Label = Label.new()
		name_label.text = cosmetic.name
		name_label.theme_override_font_sizes["font_size"] = 18
		vbox.add_child(name_label)
		
		var type_label: Label = Label.new()
		type_label.text = "Type: %s" % cosmetic.type
		type_label.theme_override_font_sizes["font_size"] = 14
		vbox.add_child(type_label)
		
		hbox.add_child(vbox)
		hbox.add_child(Control.new())
		hbox.get_child(1).size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		var purchase_button: Button = Button.new()
		var owned: bool = App.meta_state.cosmetic_ids.has(cosmetic.id)
		if owned:
			purchase_button.text = "OWNED"
			purchase_button.disabled = true
		else:
			purchase_button.text = "Buy: %d Keys" % cosmetic.price
			purchase_button.pressed.connect(_on_purchase_cosmetic.bind(cosmetic))
		hbox.add_child(purchase_button)
		
		panel.add_child(hbox)
		cosmetic_list.add_child(panel)
	
	var debug_label: Label = Label.new()
	debug_label.text = "\n[DEBUG] You can grant yourself Aether Keys for testing in the debug console."
	debug_label.theme_override_font_sizes["font_size"] = 12
	debug_label.modulate = Color(0.7, 0.7, 0.7)
	cosmetic_list.add_child(debug_label)

func _on_purchase_cosmetic(cosmetic: Dictionary) -> void:
	if not App.meta_state:
		return
	
	if App.meta_state.aether_keys >= cosmetic.price:
		App.meta_state.aether_keys -= cosmetic.price
		App.meta_state.cosmetic_ids.append(cosmetic.id)
		SaveService.save_game()
		_populate_cosmetics()

func _on_back_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
