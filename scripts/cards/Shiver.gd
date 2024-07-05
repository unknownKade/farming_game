extends Sprite2D
#
## Parameters for the shiver effect
var shiver_intensity = 2.0
var shiver_speed = 20.0
var shiver_duration = 1
var shiver_timer = 0.0
var original_position: Vector2
var shivering = false

func _ready():
	# Initialize the original position of the sprite
	original_position = position

func _process(delta):
	# Check if it's time to shiver the sprite
	if shivering and shiver_timer > 0:
		# Calculate the shiver offsets
		var offset_x = randf_range(-shiver_intensity, shiver_intensity)
		position = original_position + Vector2(offset_x, 0)
		
		# Decrease the shiver timer
		shiver_timer -= delta
		if shiver_timer <= 0:
			# Reset the position when the shiver timer is finished
			position = original_position
	elif shivering:
		#reset position on stop
		position = original_position
		shivering = false
## Function to start the shiver effect
func start_shake():
	shivering = true
	shiver_timer = shiver_duration
