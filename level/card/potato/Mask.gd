extends ColorRect

signal signal_click(is_left_click)
signal signal_hover(is_enter)

func _on_gui_input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()
	
	if !is_click or !GameManger.p1_turn or get_parent().locked:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		signal_click.emit(true)
	elif event.button_index == MOUSE_BUTTON_RIGHT and GameManger.selected_card != null and GameManger.selected_card.name == get_parent().name:
		signal_click.emit(false)

func _on_mouse_entered():
	if GameManger.p1_turn and !get_parent().locked and GameManger.selected_card == null :
		signal_hover.emit(true)

func _on_mouse_exited():
	if GameManger.p1_turn and !get_parent().locked and GameManger.selected_card == null :
		signal_hover.emit(false)
