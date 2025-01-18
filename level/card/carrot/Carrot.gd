extends Card

class_name CarrotCard

signal carrot_escaped

var dialougeManager:Node

func _ready():
	frame_set = [19,0,4,8,15]
	sync_card_level()
	anim_player = $AnimationPlayer
	sprite = $Mask/Sprite2D
	deck_anim_player = $DeckAnimationPlayer
	$Mask.signal_input.connect(process_click)
	
func come_back():
	GameManger.p1_carrot_escaped = false
	deck_anim_player.queue("escape_return")

func _on_deck_animation_player_animation_finished(anim_name):
	if anim_name == "escape":
		#anim_player.clear_queue()
		carrot_escaped.emit()
	elif anim_name == "escape_return":
		anim_player.play("RESET")
		deck_anim_player.play("RESET")
		sprite.start_shake()
	elif anim_name == "revive" :
		crop_revived.emit()
	elif anim_name == "confirm" :
		anim_player.play("seeding")
	elif anim_name == "flip" :
		self.return_card()
	elif anim_name == "return" and !%Player1.carrot_swap:
		get_parent().end_result_phase()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding":
		$Ground.visible = false
		end_player_phase.emit()
