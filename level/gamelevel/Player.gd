extends State

class_name Board

const next_state = "Garden"

var hand = {}

func _ready():
	for child in %Hand.get_children() :
		hand[child.name] = child
	
func enter():
	display_cards()
	$Timer.start()
	GameManger.player_turn = true

func display_cards():
	for card in hand :
		hand[card].level = GameManger.p1_deck[card].level
		hand[card].signal_end_turn.connect(end_player_phase)
#TODO : Display cards animation

func _on_timer_timeout():
	GameManger.confirm_card()
	end_player_phase()

func end_player_phase():
	$Timer.stop()
	GameManger.player_turn = false
	Transition.emit(self, next_state)
