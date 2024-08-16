extends Card

class_name CarrotCard

signal carrot_escaped

func _ready():
	frame_set = [19,0,4,8,15]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Mask/Sprite2D
	deck_anim_player = $DeckAnimationPlayer
	
func run_away():
	deck_anim_player.queue("escape")

func come_back():
	GameManger.p1_carrot_escaped = false
	deck_anim_player.queue("escape_return")

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "escape":
		carrot_escaped.emit()
	elif anim_name == "escape_return":
		sprite.start_shake()
	elif anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.queue("seeding")
	elif anim_name == "flip" :
		self.return_card()
	elif anim_name == "return" :
		card_return_ended.emit() #Hand

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		confirmed_card.emit()
