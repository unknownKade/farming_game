extends Sprite2D

class_name Weather

enum {
	WINTER,
	SPRING,
	SUMMER,
	FALL
}

const signal_in = "WeatherPhase"
const signal_out = "EnvironmentPhase"

func _ready():
	Signals.connect(signal_in, activate_weather)

func activate_weather():
	var weather = get_current_weather()
	display_entry_sign(weather.sign)
	play_entry_animation(weather.scene)

func get_current_weather():
	match GameManager.current_round%4:
		0 : 
			return {
				"type" : WINTER,
				"sign" : $Winter,
				"scene" : $Winter
				}
		1 : 
			return {
				"type" : WINTER,
				"sign" : $Winter,
				"scene" : $Winter
				}
		2 : 
			return SUMMER
		3 :
			return FALL

func play_entry_animation(weather):
	weather.visible = true
	weather.get_node(GameManager.animation_player).play_entry = true

func display_entry_sign(weather):
	pass

func _on_winter_signal_animation_end():
	Signals.emit_signal(signal_out)
