extends Sprite2D

class_name Environ

enum Types{
	SUNLIGHT,
	RAIN,
	MUSIC,
	LOVE
}

var scenes

var signal_in = "EnvironmentPhase"
var signal_out = "PlayerPhase"

func _ready():
	randomize()
	assign_scenes()
	Signals.connect(signal_in, activate_environment)

func activate_environment():
	var scene = scenes.get(select_environment_type())
	scene.visible = true
	scene.get_node(GameManager.animation_player).play_entry = true

func select_environment_type():
	match randi_range(0, len(Types)-1):
		0: return Types.SUNLIGHT
		1: return Types.RAIN
		2: return Types.MUSIC
		3: return Types.LOVE

func assign_scenes():
	scenes = {
		Types.SUNLIGHT : $Sunlight,
		Types.RAIN : $Sunlight,
		Types.MUSIC : $Sunlight,
		Types.LOVE : $Sunlight
	}

func _on_sunlight_signal_animation_end():
	Signals.emit_signal(signal_out)
