extends Node2D

class_name Card

signal signal_end_turn
var level : int = 1
var beet_frame = [16,0,4,8,12]
func _ready():
	level = GameManger.p1_deck[self.name].level
	change_card_image(level)

func _on_area_2d_signal_card_change(is_left_click):
	var confirming_this_card = GameManger.selected_card != null and GameManger.selected_card.name == self.name
	if is_left_click:
		if confirming_this_card :
			confirm_selected_card()
		elif GameManger.selected_card == null :
			select_card()
		else :
			return
	else :
		deselect_card()

func change_card_image(level):
	$Sprite2D.set_frame(beet_frame[level])

func confirm_selected_card():
	GameManger.confirm_card()
	self.visible = false
	signal_end_turn.emit()

func select_card():
	GameManger.select_card(self.name)
	$DeckAnimationPlayer.play("select")
	$AnimationPlayer.play(str(level))

func deselect_card():
	GameManger.deselect_card()
	$DeckAnimationPlayer.play("deselect")

func roll_dice(min_dice_req : int) -> bool:
	return randi_range(0, 4) > min_dice_req
