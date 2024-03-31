extends State

class_name Player

const next_state = "Garden"
const child_node_type = "Node2D"

signal end_player_time

var cards = []

func _ready():
	for child in get_children():
		if child is Card:
			cards.append(child.name)
			child.end_player_turn.connect(confirm_card)
	
	select_opponent_card()
	
func enter():
	$Timer.start()
	self.visible = true
	GameManger.player_turn = true

func display_cards():
	pass

func confirm_card():
	if !GameManger.opponent_card.is_empty() :
		end_player_phase()

func _on_timer_timeout():
	if GameManger.confirmed_card.is_empty() :
		if !GameManger.selected_card.is_empty() :
			GameManger.confirmed_card = GameManger.selected_card
		else :
			GameManger.confirmed_card = cards[randi_range(0,cards.size()-1)]
	
	end_player_phase()

func end_player_phase():
	$Timer.stop()
	GameManger.player_turn = false
	#self.get_node(GameManger.confirmed_card).play_confirm()
	Transition.emit(self, next_state)

func select_opponent_card():
	GameManger.opponent_card = cards[randi_range(0, cards.size()-1)]
