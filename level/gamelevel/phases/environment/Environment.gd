extends State

const next_state = "Board"

var scenes : Dictionary
var environments : Array

func _ready():
	for child in get_children():
		if child is Sprite2D and child.name != "Frame":
			environments.append(child.name)
			scenes[child.name] = child

func enter():
	reset()
	var current_environment = environments[randi_range(0, environments.size()-1)]

	GameManger.current_environment = current_environment
	var scene = scenes.get(current_environment)
	
	scene.visible = true
	
	get_node(GameManger.animation_player).play(current_environment.to_lower())
	await get_tree().create_timer(2).timeout
	Transition.emit(self, next_state)

func reset():
	for scene in scenes :
		scenes[scene].visible = false
