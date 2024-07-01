extends Control

@export var panel: PanelContainer
@export var tail: Control
@export var textbox: VBoxContainer
@export var next_arrow : TextureRect

signal clicked_dialouge

const color_dictionary = {
	Crop.potato : "009192",
	Crop.tomato : "de0030",
	Crop.carrot : "e05d00",
	Crop.beet : "a049f6",
}

const rule_textbox_size = Vector2(1536- (53 *2) -41, 170)
const game_textbox_size = Vector2(235, 0)

func setup(crop_name, text, is_rule):
	var color = color_dictionary[crop_name]
	
	if is_rule:
		textbox.get_node("Text").set_custom_minimum_size(rule_textbox_size)
	else:
		tail.setup(crop_name, color)
	
	panel.self_modulate = color
	next_arrow.self_modulate = color
	next_arrow.modulate.a = 0
	textbox.start_dialouge(crop_name, text)

func _ready():
	setup("Tomato", "Potato is back\n ldasfjlas;djflkadsjflakdjflkjadlkfj", false)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT :
		if GameManger.text_typing :
			clicked_dialouge.emit()
		else :
			self.queue_free()
