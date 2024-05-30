extends State

const win_text = "HARVEST\nSURVIVED"
const lose_text = "GAME OVER"

func enter():
	var text = is_crops_alive()
	$CenterContainer/Label.text = text
	self.visible = true
	$Gradient.fade_out = true

func _on_gradient_faded_out():
	$CenterContainer.visible = true

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
