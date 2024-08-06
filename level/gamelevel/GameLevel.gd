extends Node2D

class_name GameLevel

@export var initial_state : State
@export var last_state : State
@export_range(1,3) var test_year : int = 1
@export var timer_sec : int = 5

var current_state
var states : Dictionary

func _ready():
	$White/AnimationPlayer.play("fade_in")
	
	await get_tree().create_timer(1).timeout
	SoundManager.bgms[SoundManager.current_bgm].play()
	GameManger.current_round = test_year * 4 - 4 + 1
	
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
		GameManger.new_year()
	
	var new_state = states.get(next_state.to_lower())
	
	current_state = new_state
	new_state.enter()
