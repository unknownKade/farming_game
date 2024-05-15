extends Node2D

class_name Card

signal confirmed_card
signal crop_revived
signal card_return_ended

var level : int
var locked : bool
var frame_set : Array
var sprite : Sprite2D
var anim_player : AnimationPlayer
var deck_anim_player : AnimationPlayer

func process_click(is_left_click):
	get_node(GameManger.animation_player).stop() 

	if locked :
		return
	if is_left_click:
		if GameManger.selected_card == null :
			select_card()
		elif GameManger.selected_card.name == self.name :
			confirm_selected_card()
		else :
			return
	else :
		deselect_card()

func sync_card_level():
	var card = GameManger.p1_deck[self.name]
	self.level = card.level
	if card.level == 0 or card.state == Crop.States.LOCKED :
		self.locked = true
		
	$Mask/Sprite2D.set_frame(frame_set[level])
	$Mask.signal_click.connect(process_click)

func confirm_selected_card():
	GameManger.confirm_card()
	deck_anim_player.play("confirm")

func select_card():
	GameManger.select_card(self.name)
	deck_anim_player.play("select")
	$AnimationPlayer.play(str(level))

func deselect_card():
	self.visible = true
	GameManger.deselect_card()
	deck_anim_player.play("deselect")

func play_result_animation():
	anim_player.play("RESET")
	deck_anim_player.play("flip");

func return_card():
	if self.name == GameManger.confirmed_card.name :
		deck_anim_player.play("return")
	if GameManger.carrot_escaped :
		%Carrot.deck_anim_player.play("escape_return")
