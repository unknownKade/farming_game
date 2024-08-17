extends State

const win_text = "HARVEST\nSURVIVED"
const lose_text = "GAME OVER"
var clickable = false

func enter():
	var text = win_text if is_crops_alive() else lose_text
	$CenterContainer/Label.text = text
	self.visible = true
	$Gradient.fade_out = true

func _on_gradient_faded_out():
	$CenterContainer.visible = true
	clickable = true

func is_crops_alive() -> bool:
	for crop in GameManger.p1_deck:
		if GameManger.p1_deck[crop].level > 0 :
			continue
		else :
			return false
	
	for crop in GameManger.p2_deck:
		if GameManger.p2_deck[crop].level > 0 :
			continue
		else :
			return false
	return true

func _on_gui_input(event):
	if event is InputEventMouseButton and clickable:
		ContentManager.to_home()
