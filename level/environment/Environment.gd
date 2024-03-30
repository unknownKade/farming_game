extends Node2D

var scenes : Dictionary
var environments : Array
var signal_in = "EnvironmentPhase"
var signal_out = "PlayerPhase"

func _ready():
	for child in get_children():
		if child.get_class() == "Sprite2D" :
			environments.append(child.name)
			scenes[child.name] = child
			
	Signals.connect(signal_in, activate_environment)

func activate_environment():
	self.visible = true
	var current_environment = environments[randi_range(0, environments.size()-1)]
	var scene = scenes.get(current_environment)
	scene.visible = true
	self.get_node(GameManager.animation_player).current_enviornment = current_environment

#func _on_animation_player_animation_finished(anim_name):
	#Signals.emit_signal(signal_out)


func _on_animation_player_animation_end():
	Signals.emit_signal(signal_out)
