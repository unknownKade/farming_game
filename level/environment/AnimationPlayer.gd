extends AnimationPlayer

var first_play : bool = true
var current_enviornment : String
signal animation_end

func _process(delta):
	if get_parent().visible and !self.is_playing() and first_play and !current_enviornment.is_empty() :
		self.play(current_enviornment.to_lower())
		first_play = false
		
		await get_tree().create_timer(2).timeout
		animation_end.emit()
