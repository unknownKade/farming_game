extends ColorRect

signal signal_click(card)

func _gui_input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()

	if !is_click or !GameManger.p2_turn or GameManger.p2_deck[get_parent().name].state == Crop.States.LOCKED or GameManger.opponent_card != null:
		return
	elif event.button_index == MOUSE_BUTTON_LEFT:
		signal_click.emit(get_parent().name)
