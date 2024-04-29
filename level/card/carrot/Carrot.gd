extends Card

class_name CarrotCard

signal carrot_escaped

func _ready():
	frame_set = [19,0,4,8,15]
	sync_card_level()

func run_away():
	self.visible = true
	$DeckAnimationPlayer.play("escape")
	GameManger.carrot_escaped = true

func come_back():
	self.visible = true
	$DeckAnimationPlayer.play("escape_return")

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "escape":
		carrot_escaped.emit()
	if anim_name == "escape_return":
		$Sprite2D.start_shake()
