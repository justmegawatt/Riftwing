extends Node

func play_sfx(sfx_key: String) -> void:
	pass

func play_music(music_key: String) -> void:
	pass

func stop_music() -> void:
	pass

func set_master_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))

func set_sfx_volume(volume: float) -> void:
	pass

func set_music_volume(volume: float) -> void:
	pass
