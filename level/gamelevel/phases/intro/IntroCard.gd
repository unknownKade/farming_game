extends Sprite2D

class_name IntroCard

const path ="res://resource/images/game_level/routine/"
const extension = ".aseprite"
var display_state: bool = true
const seasons  = ["Spring", "Summer", "Autumn", "Winter"]

func enter() -> void:
	change_texture()
	$AnimationPlayer.queue("enter")
	#await $AnimationPlayer.animation_finished
	
func change_texture() -> void:
	var file_name: String = get_year(GameManger.current_round) + seasons[GameManger.current_round%4 -1]
	var load = path + file_name + extension
	#var image = Image.new()
	#var err = image.load(load)
	#
	#texture = ImageTexture.new()
	#texture.create_from_image(image)
	#self.texture = load(load)
	
	display_state = true
	self.scale.y = 0
	self.visible = true

func get_year(round : int) -> String:
	if round%4 == 0 :
		return str(round/4)
	return str(round/4 +1)
