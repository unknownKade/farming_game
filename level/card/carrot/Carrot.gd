extends Card

class_name CarrotCard

signal carrot_escaped

func _ready():
	frame_set = [19,0,4,8,15]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	deck_anim_player = $DeckAnimationPlayer
	
func run_away():
	self.visible = true
	deck_anim_player.play("escape")
	GameManger.carrot_escaped = true

func come_back():
	self.visible = true
	deck_anim_player.play("escape_return")

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "escape":
		carrot_escaped.emit()
	elif anim_name == "escape_return":
		sprite.start_shake()
	elif anim_name == "revive" :
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
