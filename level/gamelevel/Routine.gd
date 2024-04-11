extends Sprite2D

class_name IntroCard

const path ="res://resource/images/game_level/routine/"
const extension = ".aseprite"
var display_state: bool = true

func change_texture(weather):
	var file_name :String = str(GameManger.current_round/4 +1) + weather
	self.texture = load(path + file_name + extension)
	
	display_state = true
	self.scale.y = 0
	self.visible = true

func _process(delta):
	if display_state && self.scale.y <= 1:
		self.scale.y += delta * 2
	
	if !display_state && self.scale.y >= 0:
		self.scale.y -= delta * 2 
	elif !display_state:
		self.visible = false
