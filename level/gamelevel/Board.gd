extends State

class_name Board

const next_state = "Garden"

var hand : Dictionary
var is_swap : bool = false
	
func _ready():
	%Hand.get_node("Carrot").carrot_escaped.connect(enter)

func enter():
	%Hand.confirmed_card.connect(exit)
	%Hand.display_cards()
	$Timer.start()
	GameManger.player_turn = true
	
func _on_timer_timeout():
	print('timedout')
	$Timer.stop()
	GameManger.confirm_card()

func exit():
	$Timer.stop()
	Transition.emit(self, next_state)
