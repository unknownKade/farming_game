extends Node2D

class_name Deck

const signal_in = "PlayerPhase"
const signal_out = "ResultPhase"
const signal_process = "PlayerEnd"

func _ready():
	Signals.connect(signal_in, play_entry_animation)
	
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
			GameManager.confirmed_card = "random"
	
	GameManager.player_turn = false
	Signals.emit_signal(signal_out)
