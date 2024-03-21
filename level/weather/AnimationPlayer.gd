extends AnimationPlayer

var played_once :bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().visible and !self.is_playing() and !played_once:
		self.play("Entry")
		played_once = true
