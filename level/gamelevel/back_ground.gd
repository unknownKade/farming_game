extends TextureRect

func _ready() -> void:
	$Timer.start(randi_range(5,30))
	
func _on_timer_timeout() -> void:
	$Sprite2D/AnimationPlayer.play("blink")
	$Timer.start(randi_range(5,30))
