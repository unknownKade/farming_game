extends Button

func _pressed():
	SoundManager.sfx_play(&"menu_click")
	ContentManager.to_home()
