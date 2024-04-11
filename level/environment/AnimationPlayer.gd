extends AnimationPlayer

var first_play : bool = true
signal animation_end

func _process(delta):
	if get_parent().visible and !self.is_playing() and first_play and !GameManger.current_environment.is_empty() :
		self.play(GameManger.current_environment.to_lower())
		first_play = false
		
		await get_tree().create_timer(2).timeout
		animation_end.emit()
