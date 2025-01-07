extends Control
	
var side_tail_position_dictionary = {
	"Potato" : Vector2(0,50),
	"Tomato" : Vector2(0,50),
	"Beet" : Vector2(0,50),
	"Carrot" : Vector2(0,50)
}

func setup(crop_name, color) :
	var tail = $SideTail
	tail.self_modulate = color
	tail.position = side_tail_position_dictionary[crop_name]
	self.visible = true
