extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("new_animation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
