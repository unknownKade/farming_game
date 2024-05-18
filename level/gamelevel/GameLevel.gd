extends Node2D

class_name GameLevel

@export var initial_state : State
@export var last_state : State
var current_state
var states : Dictionary

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_child_transition(state, next_state):
	if state != current_state:
		return
		
	if state == last_state:
		new_year()
	
	var new_state = states.get(next_state.to_lower())
	
	current_state = new_state
	new_state.enter()
	
func new_year():
	GameManger.current_round += 1
	
	GameManger.confirmed_card = null
	GameManger.selected_card = null
	GameManger.opponent_card = null
