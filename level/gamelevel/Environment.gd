extends Sprite2D

class_name Environ

var scenes : Dictionary
var environments : Array
var signal_in = "EnvironmentPhase"
var signal_out = "PlayerPhase"

func _ready():
	for child in get_children():
		environments.append(child.type)
		scenes[child.type] = child
			
	Signals.connect(signal_in, activate_environment)

func activate_environment():
	var current_enviorn = environments[randi_range(0, environments.size()-1)]
	var scene = scenes.get(current_enviorn)
	scene.visible = true
	scene.get_node(GameManager.animation_player).play_entry = true

func _on_sunlight_signal_animation_end():
	Signals.emit_signal(signal_out)
