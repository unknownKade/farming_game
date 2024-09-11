extends Node2D

func _on_home_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	ContentManager.to_home()

func _on_pause_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	if get_tree().paused :
		get_tree().paused = false
	else :
		get_parent().get_node("CanvasLayer").visible = true
		get_tree().paused = true

func _on_option_button_pressed():
	SoundManager.sfx_play(&"menu_click")
