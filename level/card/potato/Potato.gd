extends Card

class_name PotatoCard

func _ready():
	frame_set = [33,0,6,14,25]
	$Mask.signal_input.connect(process_click)
	
func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "revive":
		crop_revived.emit()
	elif anim_name == "confirm":
		anim_player.play("seeding")
	elif anim_name == "flip":
		deck_anim_player.queue("return")
	elif anim_name == "return" and !%Player1.carrot_swap:
		%Player1.end_result_phase()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		end_player_phase.emit()
