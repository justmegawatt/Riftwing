extends Control

@onready var speaker_label: Label = %SpeakerLabel
@onready var dialogue_label: Label = %DialogueLabel
@onready var continue_button: Button = %ContinueButton

var current_dialogue: DialogueBeat
var current_line_index: int = 0

func _ready() -> void:
	continue_button.pressed.connect(_on_continue_pressed)

func show_dialogue(dialogue_id: String) -> void:
	current_dialogue = ContentDB.get_dialogue(dialogue_id)
	if not current_dialogue:
		queue_free()
		return
	
	for flag in current_dialogue.requires_flags:
		if not App.meta_state.story_flags.has(flag):
			queue_free()
			return
	
	current_line_index = 0
	_display_current_line()
	show()

func _display_current_line() -> void:
	if not current_dialogue or current_line_index >= current_dialogue.lines.size():
		_end_dialogue()
		return
	
	speaker_label.text = current_dialogue.speaker
	dialogue_label.text = current_dialogue.lines[current_line_index]

func _on_continue_pressed() -> void:
	current_line_index += 1
	if current_line_index < current_dialogue.lines.size():
		_display_current_line()
	else:
		_end_dialogue()

func _end_dialogue() -> void:
	if current_dialogue:
		for flag in current_dialogue.sets_flags:
			if not App.meta_state.story_flags.has(flag):
				App.meta_state.story_flags.append(flag)
	SaveService.save_game()
	queue_free()
