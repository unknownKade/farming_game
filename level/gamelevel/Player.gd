extends State

class_name Player

const next_state = "Garden"

var hand = {}

func _ready():
	for child in get_children():
		if child is Card:
			hand[child.name] = child
			child.signal_end_turn.connect(confirm_card)
	
func enter():
	display_cards()
	$Timer.start()
	GameManger.player_turn = true

func display_cards():
	for card in hand :
		hand[card].level = GameManger.p1_deck[card].level
		#hand[card].change_texture(hand[card].level)
	
	self.visible = true
#TODO : Display cards animation

func confirm_card():
	if GameManger.opponent_card != null:
		end_player_phase()
	else :
		GameManger.player_turn = false

func _on_timer_timeout():
	GameManger.confirm_card()
	end_player_phase()


func end_player_phase():
	$Timer.stop()
	GameManger.player_turn = false
	Transition.emit(self, next_state)
