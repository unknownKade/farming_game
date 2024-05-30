extends Sprite2D

class_name IntroCard

const path ="res://resource/images/game_level/routine/"
const extension = ".aseprite"
var display_state: bool = true

func change_texture(weather):
	var file_name :String = get_year(GameManger.current_round) + weather
	self.texture = load(path + file_name + extension)
	
	display_state = true
	self.scale.y = 0
	self.visible = true

func get_year(round : int) -> String:
	if round%4 == 0 :
		return str(round/4)
	return str(round/4 +1)
	

func _process(delta):
	#intro card appears
	if display_state && self.scale.y <= 1:
		self.scale.y += delta * 2
	
	#intro card disappears
	if !display_state && self.scale.y >= 0:
		self.scale.y -= delta * 2
	
	#hide intro card
	elif !display_state:
		self.visible = false
