extends Sprite2D

const path ="res://resource/images/game_level/routine/"
const extension = ".aseprite"
var stop_display: bool = false

func _ready():
	scale.y = 1
	
func change_texture(weather):
	var file_name :String = weather + str(GameManager.current_round/4 +1)
	self.texture = load(path + file_name + extension)
	self.visible = true
	
func _process(delta):
	if stop_display && self.scale.y > 0:
		self.scale.y -= delta * 2 
	elif stop_display :
		self.visible = false
