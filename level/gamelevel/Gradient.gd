extends TextureRect

var fade_out = false
var fade_speed = 0.5
var vector_x = 0.5
var full_vector = Vector2(vector_x, 1)
signal faded_out

func _process(delta):
	if fade_out :
		var fill = get_texture().get_fill_from()
		var vector = Vector2(vector_x,fill.y + delta * fade_speed)
		
		get_texture().set_fill_from(vector)
		
		if get_texture().get_fill_from().y > 1 :
			faded_out.emit()
			get_texture().set_fill_from(full_vector)
