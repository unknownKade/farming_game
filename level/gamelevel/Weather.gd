extends State

class_name Weather

const next_state = "Environment"
const seasons = ['Winter', 'Spring','Summer', 'Autumn']

func _ready():
	$Season.end_weather.connect(end_weather)

func enter():
	var weather = seasons[GameManger.current_round%4 - 1]
	$IntroCard.change_texture(weather)
	$Season.play_entry_animation(weather)

func end_weather():
	$IntroCard.display_state = false
	Transition.emit(self, next_state)
