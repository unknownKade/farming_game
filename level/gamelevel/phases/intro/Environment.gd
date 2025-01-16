extends Node2D

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
var scenes : Dictionary
var environments : Array
var current_environment

func _ready() -> void:
	for child in get_children():
		if child is Sprite2D and child.name != "Frame":
			environments.append(child.name)
			scenes[child.name] = child

func enter() -> void:
	next_environment()
	$Timer.start(randi_range(5,10))

func next_environment() -> void:
	reset()
	current_environment = environments[randi_range(0, environments.size()-1)]

	GameManger.current_environment = current_environment
	var scene = scenes.get(current_environment)
	
	scene.visible = true
	
	get_node(GameManger.animation_player).play(current_environment.to_lower())

func reset():
	for scene in scenes :
		scenes[scene].visible = false

func _on_timer_timeout() -> void:
	anim_player.play(current_environment.name.to_lower())
	$Timer.start(randi_range(5,10))
