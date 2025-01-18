extends Sprite2D

var level:int = 1
var state:String = ""
var locked = false
var shiver_intensity = 2.0
var shiver_speed = 20.0
var shiver_duration = 1
var shiver_timer = 0.0
var original_position: Vector2
var shivering = false

func _ready():
	original_position = position

func revive():
	var dead_arr = []
	for child in %Player1.get_children():
		if child.level == 0:
			dead_arr.append(child)
	if dead_arr.is_empty():
		return null
	else:
		return dead_arr[randi_range(0, len(dead_arr)-1)]
		
func _process(delta):
	if shivering and shiver_timer > 0:
		var offset_x = randf_range(-shiver_intensity, shiver_intensity)
		position = original_position + Vector2(offset_x, 0)
		
		shiver_timer -= delta
		if shiver_timer <= 0:
			position = original_position
	elif shivering:
		position = original_position
		shivering = false

func start_shake():
	shivering = true
	shiver_timer = shiver_duration
