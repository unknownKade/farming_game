extends Node2D

const color_dictionary = {
	Crop.potato : "009192",
	Crop.tomato : "de0030",
	Crop.carrot : "e05d00",
	Crop.beet : "a049f6",
}
const margin = 53
const pos_unit = (1536 -(53 * 2))/4
const dialouge_init_position = Vector2(54, 462)

@export var dialouge : PackedScene
var speech
const tail_position = {
	Crop.potato : pos_unit * 0.5 + margin,
	Crop.tomato : pos_unit * 1.5  + margin,
	Crop.carrot : pos_unit * 2.5 + margin,
	Crop.beet : pos_unit * 3.5 + margin,
}

const crop_text ={
	Crop.potato : "potato potaotdot , adfjpoddf pto todt podrj paoj\n !kljdalkfjlkeiowee",
	Crop.tomato : "tomato tomato , adfjpoddf tomato todt podrj paoj\n !ktomatodasdfa",
	Crop.carrot : "carrot carrot , adfjpoddf pto todt podrj paoj\n !kljdalkfjlkeiowee",
	Crop.beet : "beet beet , adfjpoddf pto todt podrj p\naoj adsfdsf  asdfadf  adsfasd f\n !kljdalkfjlkeiowee",
}

func _ready():
	setup(Crop.tomato, crop_text[Crop.tomato])
	
func setup(crop, text):
	speech = dialouge.instantiate()
	speech.position = dialouge_init_position
	add_child(speech)
	$TopTail.self_modulate = color_dictionary[crop]
	$TopTail.position.x = tail_position[crop]
	speech.setup(crop,text,true)

func _on_potato_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		setup(Crop.potato, crop_text[Crop.potato])

func _on_tomato_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		setup(Crop.tomato, crop_text[Crop.tomato])

func _on_carrot_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		setup(Crop.carrot, crop_text[Crop.carrot])

func _on_beet_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		setup(Crop.beet, crop_text[Crop.beet])
