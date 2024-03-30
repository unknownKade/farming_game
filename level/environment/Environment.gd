extends State

var scenes : Dictionary
var environments : Array
const next_state = "Deck"
const child_node_type = "Sprite2D"

func _ready():
	for child in get_children():
		if child.get_class() == child_node_type :
			environments.append(child.name)
			scenes[child.name] = child

func enter():
	var current_environment = environments[randi_range(0, environments.size()-1)]
	var scene = scenes.get(current_environment)
	
	self.visible = true
	scene.visible = true
	self.get_node(GameManger.animation_player).current_enviornment = current_environment

func _on_animation_player_animation_end():
	Transition.emit(self, next_state)
