extends AnimationPlayer

var play_entry :bool = true

func _process(delta):
	if get_parent().visible and !self.is_playing() and play_entry:
		self.play("Entry")
		play_entry = false
