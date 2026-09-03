extends Control

@onready var talent_container: VBoxContainer = %TalentContainer
@onready var back_button: Button = %BackButton

func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	_populate_talents()

func _populate_talents() -> void:
	if not App.meta_state:
		return
	
	var resonance: ResonanceDef = ContentDB.get_resonance(App.meta_state.resonance_id)
	if not resonance:
		return
	
	var talent_ids: Array[String] = []
	
	if resonance.id == "striker":
		talent_ids.append("striker_fang_1")
	elif resonance.id == "warden":
		talent_ids.append("warden_hide_1")
	elif resonance.id == "hexer":
		talent_ids.append("hexer_fang_1")
	
	talent_ids.append("keywright_seal")
	
	for talent_id in talent_ids:
		var talent: TalentNode = ContentDB.get_talent(talent_id)
		if not talent:
			continue
		
		var is_unlocked: bool = App.meta_state.unlocked_talent_ids.has(talent_id)
		var can_afford: bool = App.meta_state.essence >= talent.cost_essence
		
		var button: Button = Button.new()
		var status: String = ""
		if is_unlocked:
			status = " [UNLOCKED]"
		elif can_afford:
			status = " (Can Purchase)"
		else:
			status = " (Need %d Essence)" % talent.cost_essence
		
		button.text = "%s - %d Essence%s\n%s" % [talent.display_name, talent.cost_essence, status, talent.description]
		button.disabled = is_unlocked or not can_afford
		button.pressed.connect(_on_talent_pressed.bind(talent_id))
		talent_container.add_child(button)

func _on_talent_pressed(talent_id: String) -> void:
	var talent: TalentNode = ContentDB.get_talent(talent_id)
	if not talent or not App.meta_state:
		return
	
	if App.meta_state.essence >= talent.cost_essence:
		App.meta_state.essence -= talent.cost_essence
		App.meta_state.unlocked_talent_ids.append(talent_id)
		Events.talent_unlocked.emit(talent_id)
		SaveService.save_game()
		
		for child in talent_container.get_children():
			child.queue_free()
		_populate_talents()

func _on_back_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
