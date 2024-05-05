extends Node

class_name Player2

@export_enum("Tomato", "Beet", "Carrot", "Potato") var test_crop : String

func _ready():
	%Board.player_turn_started.connect(start_turn)

func start_turn():
	get_random_card()

func get_random_card():
	var live_cards: Array
	
	for crop in GameManger.p2_deck:
		if GameManger.p2_deck[crop].level > 0 :
			live_cards.append(GameManger.p2_deck[crop])
	
	if !test_crop.is_empty() :
		GameManger.opponent_card = GameManger.p2_deck[test_crop]
	else :
		GameManger.opponent_card = live_cards[randi_range(0, live_cards.size() -1)]
