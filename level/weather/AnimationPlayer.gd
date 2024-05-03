extends AnimationPlayer

var first_play : bool = true
var play_entry :bool = true
var current_season :String

func _process(delta):
	if !self.is_playing() and first_play and !current_season.is_empty():
		self.play(current_season.to_lower())
		first_play = false
