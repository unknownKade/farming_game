extends State

class_name Board

const next_state = "Garden"

var hand : Dictionary
var is_swap : bool = false
@export var timer : Node

func _ready():
	%Hand.get_node("Carrot").carrot_escaped.connect(enter)

func enter():
	%Hand.confirmed_card.connect(exit)
	%Hand.display_cards()
	timer.start()
	GameManger.player_turn = true

func _on_timer_timeout():
	timer.stop()
	if GameManger.player_turn:
		GameManger.confirm_card()

func exit():
	timer.stop()
	Transition.emit(self, next_state)

func get_timer_time() -> String:
	return str(roundi(timer.time_left))
