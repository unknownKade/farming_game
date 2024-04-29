extends Sprite2D

# Parameters for the shake effect
var shake_intensity = 10.0
var shake_speed = 30.0
var shake_duration = 0.5
var shake_timer = 0.0
var original_position

func _ready():
	# Initialize the original position of the sprite
	original_position = position

func _process(delta):
	# Check if it's time to shake the sprite
	if shake_timer > 0:
		# Calculate the shake offset
		var shake_offset = Vector2(randi_range(-shake_intensity, shake_intensity), randi_range(-shake_intensity, shake_intensity))
		position = original_position + shake_offset
		
		# Decrease the shake timer
		shake_timer -= delta * shake_speed
		if shake_timer <= 0:
			# Reset the position when the shake timer is finished
			position = original_position
	else:
		# If not shaking, reset position
		position = original_position

# Function to start the shake effect
func start_shake():
	shake_timer = shake_duration
