extends Node2D

var scenes : Dictionary
var environments : Array

func _ready():
	for child in get_children():
		if child is Sprite2D and child.name != "Frame":
			environments.append(child.name)
			scenes[child.name] = child

func enter():
	next_environment()
	#get_node(GameManger.animation_player).play("rain")

func next_environment():
	reset()
	var current_environment = environments[randi_range(0, environments.size()-1)]

	GameManger.current_environment = current_environment
	var scene = scenes.get(current_environment)
	
	scene.visible = true
	
	get_node(GameManger.animation_player).queue(current_environment.to_lower())

func reset():
	for scene in scenes :
		scenes[scene].visible = false
