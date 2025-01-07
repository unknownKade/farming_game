extends Node2D

@export var dialouge : PackedScene

const margin = 53
const pos_unit = (1536 -(53 * 2))/4
const dialouge_init_position = Vector2(54, 462)
const card_container_pos = Vector2(55,76)
const dialouge_event_type = "rule"
var speech

const tail_position = {
	Crop.potato : pos_unit * 0.5 + margin,
	Crop.tomato : pos_unit * 1.5  + margin,
	Crop.carrot : pos_unit * 2.5 + margin,
	Crop.beet : pos_unit * 3.5 + margin,
}

func reset():
	$TopTail.visible = false
	$AnimationPlayer.play_backwards("slide_cards")
	
func setup(crop, event):
	$AnimationPlayer.play("slide_cards")
	speech = dialouge.instantiate()
	speech.finished_text.connect(reset)
	speech.position = dialouge_init_position
	add_child(speech)
	setup_tail(crop)
	speech.setup(crop, event, true)

func setup_tail(crop):
	$TopTail.self_modulate = ContentManager.color_dictionary[crop]
	$TopTail.position.x = tail_position[crop]
	$TopTail.visible = true

func _on_potato_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and !GameManger.text_typing and speech == null:

		setup(Crop.potato, dialouge_event_type)

func _on_tomato_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and !GameManger.text_typing and speech == null:
		setup(Crop.tomato, dialouge_event_type)

func _on_carrot_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and !GameManger.text_typing and speech == null:
		setup(Crop.carrot, dialouge_event_type)

func _on_beet_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and !GameManger.text_typing and speech == null:
		setup(Crop.beet,dialouge_event_type)

func _on_home_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	get_tree().change_scene_to_file(ContentManager.menu_scene_path)
