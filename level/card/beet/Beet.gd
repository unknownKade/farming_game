extends Card

class_name BeetCard

func _ready():
	frame_set = [16,0,4,8,12]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Mask/Sprite2D
	deck_anim_player = $DeckAnimationPlayer
	$Mask.signal_input.connect(process_click)
	
func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "revive":
		crop_revived.emit()
	elif anim_name == "confirm":
		anim_player.play("seeding")
	elif anim_name == "flip":
		self.return_card()
	elif anim_name == "return" and !%Player1.carrot_swap:
		get_parent().end_result_phase()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		end_player_phase.emit()

func revive():
	var dead_arr = []
	for child in %Player2.get_children():
		if child is Node2D:
			if child.level == 0:
				dead_arr.append(child)
	
	if dead_arr.is_empty():
		return null
	else:
		return dead_arr[randi_range(0, len(dead_arr)-1)]
