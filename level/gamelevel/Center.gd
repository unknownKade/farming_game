extends Sprite2D

const path ="res://resource/images/card/"
const extension = ".png"
var new_level
var swapped = false

func result(old_level, new_level):
	change_texture(GameManger.confirmed_card, old_level)
	self.swapped = false
	self.new_level = new_level
	self.visible = true
	$AnimationPlayer.play("flip")
	
func _process(delta):
	if self.scale.x < 0.1 :
		change_texture(GameManger.confirmed_card, new_level)
		swapped = true
	if swapped and self.scale.x > 0.9 * 5 :
		self.scale. x = 5

func change_texture(card,level):
	var file_name :String = card + str(level)
	self.texture = load(path + file_name + extension)
