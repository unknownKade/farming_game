extends Sprite2D

class_name Weather
const seasons = ['Winter','Winter', 'Winter', 'Winter']

const signal_in = "WeatherPhase"
const signal_out = "EnvironmentPhase"

var scenes : Dictionary

func _ready():
	Signals.connect(signal_in, activate_weather)
	
	for child in get_children():
		scenes[child.name]= child
		
func activate_weather():
	var weather = seasons[GameManager.current_round%4]
	display_entry_sign(weather)
	play_entry_animation(scenes.get(weather))

func play_entry_animation(scene):
	scene.visible = true
	scene.get_node(GameManager.animation_player).play_entry = true
	
func display_entry_sign(weather):
	$Routine.change_texture(weather)

	
func _on_winter_signal_animation_end():
	$Routine.stop_display = true
	Signals.emit_signal(signal_out)
