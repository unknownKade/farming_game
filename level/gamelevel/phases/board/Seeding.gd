extends ColorRect

const path ="res://resource/images/card/"
const extension = ".png"

func change_texture(card,level):
	var file_name :String = card + str(level)
	$Sprite2D.texture = load(path + file_name + extension)
