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
	
	match resonance.id:
		"striker":
			talent_ids.append("striker_fang_1")
		"warden":
			talent_ids.append("warden_hide_1")
		"hexer":
			talent_ids.append("hexer_fang_1")
		"nightthread":
			talent_ids.append("nightthread_drift_1")
		"bindscript":
			talent_ids.append("bindscript_fang_1")
		"heartwell":
			talent_ids.append("heartwell_hide_1")
	
	talent_ids.append_array(["keywright_seal", "keywright_flip", "keywright_reroute", "keywright_steal", "keywright_lock"])
	
	for talent_id in talent_ids:
		var talent: TalentNode = ContentDB.get_talent(talent_id)
		if not talent:
			continue
		
		var is_unlocked: bool = App.meta_state.unlocked_talent_ids.has(talent_id)
		var prereqs_met: bool = true
		for prereq_id in talent.prereqs:
			if not App.meta_state.unlocked_talent_ids.has(prereq_id):
				prereqs_met = false
				break
		
		var can_afford: bool = App.meta_state.essence >= talent.cost_essence
		var can_purchase: bool = prereqs_met and can_afford and not is_unlocked
		
		var button: Button = Button.new()
		var status: String = ""
		if is_unlocked:
			status = " [UNLOCKED]"
		elif not prereqs_met:
			status = " (Locked - need prereqs)"
		elif can_afford:
			status = " (Can Purchase)"
		else:
			status = " (Need %d Essence)" % talent.cost_essence
		
		button.text = "%s - %d Essence%s\n%s" % [talent.display_name, talent.cost_essence, status, talent.description]
		button.theme_override_font_sizes["font_size"] = 14
		button.disabled = not can_purchase
		button.pressed.connect(_on_talent_pressed.bind(talent_id))
		talent_container.add_child(button)

func _on_talent_pressed(talent_id: String) -> void:
	var talent: TalentNode = ContentDB.get_talent(talent_id)
	if not talent or not App.meta_state:
		return
	
	if App.meta_state.essence >= talent.cost_essence:
		App.meta_state.essence -= talent.cost_essence
		App.meta_state.unlocked_talent_ids.append(talent_id)
		
		if talent.unlock_ability_id != "":
			App.meta_state.unlocked_rewrite_verbs.append(talent.unlock_ability_id)
		
		Events.talent_unlocked.emit(talent_id)
		SaveService.save_game()
		
		for child in talent_container.get_children():
			child.queue_free()
		_populate_talents()

func _on_back_pressed() -> void:
	App.change_scene("res://scenes/hub/hub.tscn")
