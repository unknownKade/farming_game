extends Node

class_name Player2

@export var board : Node2D

func _ready():
	board.player_turn_started.connect(start_turn)

func start_turn():
	get_random_card()

func get_random_card():
	var live_cards: Array
	
	for crop in GameManger.p2_deck:
		if GameManger.p2_deck[crop].level > 0 :
			live_cards.append(GameManger.p2_deck[crop])
	
	#GameManger.opponent_card = live_cards[randi_range(0, live_cards.size() -1)]
	GameManger.opponent_card = GameManger.p2_deck["Tomato"]
