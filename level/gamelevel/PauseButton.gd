extends TextureButton

func _pressed():
	SoundManager.sfx_play(&"menu_click")
	#unpause
	if get_tree().paused :
		%Instructions.visible = false
		get_tree().paused = false
	#pause
	else :
		%Instructions.visible = true
		get_tree().paused = true
