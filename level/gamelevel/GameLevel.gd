extends Node2D

class_name GameLevel

@export var initial_state : State
@export var last_state : State
@export_range(1,3) var test_year : int = 1
@export var timer_sec : int = 5

var current_state
var states : Dictionary

func _ready():
	$CanvasLayer/AnimationPlayer.play("fade_in")
	
	GameManger.current_round = test_year * 4 - 4 + 1
	current_state = initial_state
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transition.connect(on_child_transition)

func on_child_transition(state, next_state):
	if state != current_state:
		print("current_state: {}", current_state)
		print("state: {}", state)
		print("next state : {}", next_state)
		return
		
	if state == last_state:
		GameManger.new_year()
	
	var new_state = states.get(next_state.to_lower())
	
	current_state = new_state
	new_state.enter()
	
func _on_instruction_instruction_clicked():
	if current_state == initial_state:
		initial_state.enter()
	
	if get_tree().paused :
		$CanvasLayer.hide()
		get_tree().paused = false

func _on_animation_player_animation_finished(anim_name):
	await get_tree().create_timer(1).timeout
	$CanvasLayer/Instruction.show()
	SoundManager.play_bgm()
