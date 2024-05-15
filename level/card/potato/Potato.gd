extends Card

class_name PotatoCard

func _ready():
	frame_set = [33,0,6,14,25]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	deck_anim_player = $DeckAnimationPlayer

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.play("seeding")
	elif anim_name == "flip" :
		self.return_card()
	elif anim_name == "return" :
		card_return_ended.emit()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		anim_player.play("reset")
		$Ground.visible = false
		confirmed_card.emit()
