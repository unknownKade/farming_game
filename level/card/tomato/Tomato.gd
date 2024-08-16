extends Card

class_name TomatoCard

func _ready():
	frame_set = [31,0,7,17,24]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Mask/Sprite2D
	deck_anim_player = $DeckAnimationPlayer

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.queue("seeding")
	elif anim_name == "flip" :
		self.return_card()
	elif anim_name == "return" :
		card_return_ended.emit()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		confirmed_card.emit()
