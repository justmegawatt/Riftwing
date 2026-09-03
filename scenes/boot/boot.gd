extends Node

func _ready() -> void:
	if SaveService.load_game():
		App.change_scene("res://scenes/hub/hub.tscn")
	else:
		App.change_scene("res://scenes/ui/title.tscn")
