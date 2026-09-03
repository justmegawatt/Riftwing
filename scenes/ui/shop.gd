extends Control

@onready var item_list: VBoxContainer = %ItemList
@onready var back_button: Button = %BackButton
@onready var essence_label: Label = %EssenceLabel
@onready var fragments_label: Label = %FragmentsLabel

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	_update_shop()

func _update_shop() -> void:
	if not App.meta_state:
		return
	
	essence_label.text = "Essence: %d" % App.meta_state.essence
	fragments_label.text = "Fragments: %d" % App.meta_state.fragments
	
	for child in item_list.get_children():
		child.queue_free()
	
	var shop_items: Array[Dictionary] = [
		{"name": "Key Charge Refill", "cost_essence": 50, "type": "consumable"},
		{"name": "HP Potion", "cost_essence": 30, "type": "consumable"},
		{"name": "Talent Respec Token", "cost_fragments": 20, "type": "convenience"},
		{"name": "Gate Intel (reveals modifiers)", "cost_fragments": 15, "type": "info"},
	]
	
	for item in shop_items:
		var button: Button = Button.new()
		var cost_text: String = ""
		if item.has("cost_essence"):
			cost_text = "%d Essence" % item.cost_essence
		elif item.has("cost_fragments"):
			cost_text = "%d Fragments" % item.cost_fragments
		
		button.text = "%s - %s" % [item.name, cost_text]
		button.theme_override_font_sizes["font_size"] = 16
		button.pressed.connect(_on_item_purchased.bind(item))
		item_list.add_child(button)

func _on_item_purchased(item: Dictionary) -> void:
	if not App.meta_state:
		return
	
	var can_afford: bool = false
	if item.has("cost_essence") and App.meta_state.essence >= item.cost_essence:
		App.meta_state.essence -= item.cost_essence
		can_afford = true
	elif item.has("cost_fragments") and App.meta_state.fragments >= item.cost_fragments:
		App.meta_state.fragments -= item.cost_fragments
		can_afford = true
	
	if can_afford:
		SaveService.save_game()
		_update_shop()

func _on_back_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
