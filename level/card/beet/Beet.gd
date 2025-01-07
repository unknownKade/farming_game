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
	if anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.queue("seeding")
	elif anim_name == "flip" :
		self.return_card()
	elif anim_name == "return" :
		get_parent().end_result_phase()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		end_player_phase.emit()
