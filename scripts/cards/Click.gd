extends Area2D

signal signal_card_change(is_left_click)

var mouse_in : bool = false
func _input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()
	
	if !is_click or !GameManger.p1_turn or get_parent().locked:
		return
	
	if mouse_in and event.button_index == MOUSE_BUTTON_LEFT and GameManger.confirmed_card == null:
		signal_card_change.emit(true)
	elif event.button_index == MOUSE_BUTTON_RIGHT and GameManger.selected_card != null and GameManger.selected_card.name == get_parent().name:
		signal_card_change.emit(false)
		
func _mouse_enter():
	mouse_in = true

func _mouse_exit():
	mouse_in = false
