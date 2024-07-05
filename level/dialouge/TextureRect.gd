extends TextureRect

var modulate_color = "ffffff"
@export var blink_interval = 0.5


func blink():
	if modulate.a == 1 :
		modulate.a = 0
	else :
		modulate.a = 1
	$NextArrowTimer.start(blink_interval)

func _on_next_arrow_timer_timeout():
	blink()
