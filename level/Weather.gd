extends Sprite2D

signal signal_enivornment()

var current_weather

func draw_weather_card(current_phase: int):
	current_weather = get_season_from_phase(current_phase)
	current_weather.visible = true
	
func get_season_from_phase(current_phase: int):
	match current_phase%4:
		1:
			return $Winter
		2:
			return $Winter
		3:
			return $Winter
		0:
			return $Winter

func _on_winter_signal_animation_end():
	signal_enivornment.emit()
