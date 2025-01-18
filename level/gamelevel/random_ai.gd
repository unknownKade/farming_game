extends Node

var is_turn:bool = false
var play_card:Node

func choose_card():
	is_turn = true
	$Timer.start(3)
		
func _on_timer_timeout() -> void:
	var playble_cards = []
	if %Player2.selected_card == null and is_turn:
		for child in %Player2.get_children():
			if child is Node2D:
				if !child.locked and child.level > 0 :
					playble_cards.append(child)
				
		play_card = playble_cards[randi_range(0, len(playble_cards)-1)]
		%Player2.process_click(play_card)
		$Timer.start(1)
	elif %Player2.selected_card == play_card and is_turn:
		%Player2.process_click(play_card)
		is_turn = false
	else:
		$Timer.stop()
		is_turn = false
