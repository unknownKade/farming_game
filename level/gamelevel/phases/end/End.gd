extends State

const win_text = "HARVEST\nSURVIVED"
const lose_text = "GAME OVER"
var clickable = false
@export var both_text:String
@export var p1_text:String
@export var p2_text:String
func enter():
	var p1_alive = is_crops_alive(%Player1)
	var p2_alive = is_crops_alive(%Player2)
	var text = win_text if p1_alive and p2_alive else lose_text 
	var small_text:String = ""
	
	if p1_alive and p2_alive:
		small_text = both_text
	elif p1_alive:
		small_text = p1_text
	elif p2_alive:
		small_text = p2_text
	
	$CenterContainer/VBoxContainer/Label.text = text
	$CenterContainer/VBoxContainer/RichTextLabel.text = small_text
	self.visible = true
	$Gradient.fade_out = true

func _on_gradient_faded_out():
	$CenterContainer.visible = true
	clickable = true

func is_crops_alive(player:Node) -> bool:
	for child in player.get_children():
		if child.level > 0 :
			continue
		else :
			return false
	return true

func _on_gui_input(event):
	if event is InputEventMouseButton and clickable:
		ContentManager.to_home()
