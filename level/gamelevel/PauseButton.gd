extends TextureButton

func _pressed():
	SoundManager.sfx_play(&"menu_click")
	if get_tree().paused :
		get_tree().paused = false
	else :
		%CanvasLayer.visible = true
		get_tree().paused = true
