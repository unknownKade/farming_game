extends State

const win_text = "HARVEST\nSURVIVED"
const lose_text = "GAME OVER"
var clickable = false
func enter():
	var text = is_crops_alive()
	$CenterContainer/Label.text = text
	self.visible = true
	$Gradient.fade_out = true

func _on_gradient_faded_out():
	$CenterContainer.visible = true
	clickable = true

func is_crops_alive():
	for crop in GameManger.p1_deck:
		if GameManger.p1_deck[crop].level > 0 :
			continue
		else :
			return lose_text
	
	for crop in GameManger.p2_deck:
		if GameManger.p2_deck[crop].level > 0 :
			continue
		else :
			return lose_text
	return win_text

func _on_gui_input(event):
	if event is InputEventMouseButton and clickable:
		get_tree().change_scene_to_file(ContentManager.menu_scene_path)
