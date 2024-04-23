extends Node2D

class_name Card

signal signal_end_turn

var level
var locked : bool
var frame_set

func _on_area_2d_signal_card_change(is_left_click):
	get_node(GameManger.animation_player).stop()
	var confirming_this_card = GameManger.selected_card != null and GameManger.selected_card.name == self.name
	#TODO: issue FARM-66 click miss when overlapping locked card
	if locked :
		return
	if is_left_click:
		if confirming_this_card :
			confirm_selected_card()
		elif GameManger.selected_card == null :
			select_card()
		else :
			return
	else :
		deselect_card()

func sync_card_level():
	level = GameManger.p1_deck[self.name].level
	$Sprite2D.set_frame(frame_set[level])

func confirm_selected_card():
	GameManger.confirm_card()
	self.visible = false
	signal_end_turn.emit()

func select_card():
	GameManger.select_card(self.name)
	$DeckAnimationPlayer.play("select")
	$AnimationPlayer.play(str(level))

func deselect_card():
	self.visible = true
	GameManger.deselect_card()
	$DeckAnimationPlayer.play("deselect")

func return_card():
	sync_card_level()
	self.visible = true
	if self.name == GameManger.confirmed_card.name :
		$DeckAnimationPlayer.play("return")
