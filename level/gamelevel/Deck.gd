extends Node2D

class_name Deck

const signal_in = "PlayerPhase"
const signal_out = "ResultPhase"
const signal_process = "PlayerEnd"

var cards = []

func _ready():
	Signals.connect(signal_in, play_entry_animation)
	
	for child in get_children():
		if child.get_class() == 'Node2D':
			cards.append(child.type)
			
	select_opponent_card()
	
func play_entry_animation():
	Signals.connect(signal_process, end_player_phase)
	
	$Timer.start()
	GameManager.player_turn = true

func end_player_phase():
	if GameManager.opponent_card != null :
		$Timer.stop()
		GameManager.player_turn = false
		Signals.emit_signal(signal_out)

func _on_timer_timeout():
	if GameManager.confirmed_card == null :
		if GameManager.selected_card != null :
			GameManager.confirmed_card = GameManager.selected_card
		else :
			GameManager.confirmed_card = cards[randi_range(0,cards.size()-1)]
	
	GameManager.player_turn = false
	Signals.emit_signal(signal_out)
	
func select_opponent_card():
	GameManager.opponent_card = cards[randi_range(0, cards.size()-1)]
