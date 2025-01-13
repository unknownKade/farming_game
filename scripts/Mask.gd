extends ColorRect

class_name CardMask

signal signal_input(event)

enum InputType{
	LB, RB, IN, OUT
}

func _on_gui_input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()
	
	if !is_click:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		signal_input.emit(InputType.LB)
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		signal_input.emit(InputType.RB)

#func _on_mouse_entered():
	#if !get_parent().locked:
		#signal_input.emit(InputType.IN)
#
#func _on_mouse_exited():
	#if !get_parent().locked:
		#signal_input.emit(InputType.OUT)
