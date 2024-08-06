extends Node2D

func _on_home_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	SoundManager.bgms[SoundManager.current_bgm].stop()
	get_tree().change_scene_to_file(ContentManager.menu_scene_path)

func _on_pause_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	get_tree().paused = true

func _on_option_button_pressed():
	SoundManager.sfx_play(&"menu_click")
