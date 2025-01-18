extends Node2D

class_name GameLevel

@export_range(1,3) var test_year: int = 1
@export var phases: Array[Node]
@export var instructions: Node
var current_state: Node
var current_phase: int = 0
var states: Dictionary

func _ready():
	%Instructions.visible = true
	%Instructions.instruction_clicked.connect(_on_instruction_click)
	SoundManager.play_bgm()
	for phase in phases:
		phase.Transition.connect(on_state_exit)
	instructions.get_node(GameManger.animation_player).play("fade_in")
	
func on_state_exit(state: Node):
	if state == phases[-1]:
		GameManger.current_round += 1
		%Player1.played_card = null
		%Player2.played_card = null
		current_phase =0
	else :
		current_phase +=1
		
	phases[current_phase].enter()
	
func _on_instruction_click():
	if GameManger.current_round == 0 :
		GameManger.current_round = test_year * 4 - 4 + 1
		phases[current_phase].enter()

func reset():
	for child in %Player1.get_children():
		child.level =1
	
	for child in %Player2.get_children():
		if child is Node2D:
			child.level =1
	
	GameManger.current_round = 0
	%Instructions.first_time = true
	
