extends Node2D

@export var timer_label : Node

func _process(delta):
	if GameManger.player_turn :
		timer_label.text = %Board.get_timer_time()
	else :
		timer_label.text = ""
	
