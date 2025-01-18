extends ColorRect

signal signal_click(card)

#@onready var p2:Node = get_parent().get_parent()
#@onready var player:Node = get_parent().get_parent().get_parent()

func _gui_input(event):
	var is_click : bool = event is InputEventMouseButton and event.is_pressed()

	if !is_click or GameManger.random_ai:
		return
	elif event.button_index == MOUSE_BUTTON_LEFT:
		signal_click.emit(get_parent())
