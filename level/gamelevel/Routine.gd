extends Sprite2D

const path ="res://resource/images/game_level/routine/"
const extension = ".aseprite"

func change_texture(weather):
	var file_name :String = weather + str(GameManager.current_round/4 +1)
	self.texture = load(path + file_name + extension)
