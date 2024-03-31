extends Node2D

class_name Card

signal end_player_turn
var level = 1

func _on_area_2d_signal_card_change(is_left_click):
	if is_left_click :
		#confirming selected card
		if GameManger.selected_card == self.name :
			GameManger.confirmed_card = self.name
			self.visible = false
			end_player_turn.emit()
		#don't select card when another card is selected
		elif !GameManger.selected_card.is_empty():
			return
		#select card
		else :
			GameManger.selected_card = self.name
			play_select()
			
	#deselect card
	else :
		GameManger.selected_card = ""
		play_deselect()

func play_select():
	$DeckAnimationPlayer.play("select")
	$AnimationPlayer.play(str(level))

func play_deselect():
	$DeckAnimationPlayer.play("deselect")
