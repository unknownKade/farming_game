extends Card

class_name TomatoCard

func _ready():
	frame_set = [31,0,7,17,24]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	deck_anim_player = $DeckAnimationPlayer

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.play("seeding")
	elif anim_name == "return" :
		card_return_ended.emit()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		anim_player.play("reset")
		$Ground.visible = false
		confirmed_card.emit()
