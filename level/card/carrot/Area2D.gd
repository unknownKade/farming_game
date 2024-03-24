extends Area2D

signal signal_card_change(is_select)

var mouse_in : bool = false
func _input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()
	
	if !is_click or !GameManager.player_turn :
		return
	
	if mouse_in and event.button_index == MOUSE_BUTTON_LEFT :
		signal_card_change.emit(true)
	elif GameManager.selected_card == get_parent() and event.button_index == MOUSE_BUTTON_RIGHT :
		signal_card_change.emit(false)
		
func _mouse_enter():
	mouse_in = true

func _mouse_exit():
	mouse_in = false
