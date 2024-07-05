extends Control
	
var side_tail_position_dictionary = {
	Crop.potato : Vector2(0,50),
	Crop.tomato : Vector2(0,50),
	Crop.beet : Vector2(0,50),
	Crop.carrot : Vector2(0,50)
}

func setup(crop_name, color) :
	var tail = $SideTail
	tail.self_modulate = color
	tail.position = side_tail_position_dictionary[crop_name]
	self.visible = true
