extends Node2D

class_name Card

signal end_player_turn

func _on_area_2d_signal_card_change(is_left_click):
	if is_left_click :
		#confirming selected card
		if GameManger.selected_card == self.type :
			GameManger.confirmed_card = self.type
			play_confirm()
			end_player_turn.emit()
		#don't select card when another card is selected
		elif GameManger.selected_card != null:
			return
		#select card
		else :
			GameManger.selected_card = self.type
			play_select()
			
	#deselect card
	else :
		GameManger.selected_card = null
		play_deselect()

func play_select():
	$DeckAnimationPlayer.play("select")

func play_deselect():
	$DeckAnimationPlayer.play("deselect")
	
func play_confirm():
	%Ground/Mask.visible = true
	%Ground/Sprite2D.visible = true
	$DeckAnimationPlayer.play("confirm")
