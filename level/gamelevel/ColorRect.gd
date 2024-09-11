extends ColorRect

signal signal_click(card)

func _gui_input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()

	if !is_click or !GameManger.p2_turn or GameManger.p2_deck[get_parent().name].state == Crop.States.LOCKED or GameManger.opponent_card != null:
		return
	elif event.button_index == MOUSE_BUTTON_LEFT:
		signal_click.emit(get_parent().name)


func _on_mouse_entered():
	var crop_name = get_parent().name
	var is_locked = GameManger.p2_deck[crop_name].state == Crop.States.LOCKED
	var anim_name = crop_name.to_lower() + "_hover"
	
	if GameManger.p2_turn and !is_locked and GameManger.opponent_card == null :
		%Player2.get_node(GameManger.animation_player).queue(anim_name)

func _on_mouse_exited():
	var crop_name = get_parent().name
	var is_locked = GameManger.p2_deck[crop_name].state == Crop.States.LOCKED
	var anim_name = crop_name.to_lower() + "_hover"
	
	if GameManger.p2_turn and !is_locked and GameManger.opponent_card == null :
		%Player2.get_node(GameManger.animation_player).play_backwards(anim_name)
