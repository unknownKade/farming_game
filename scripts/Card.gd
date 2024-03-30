extends Node2D

class_name Card

const signal_out = 'PlayerEnd'

func _on_area_2d_signal_card_change(is_left_click):
	if is_left_click :
		#confirming selected card
		if GameManager.selected_card == self.type :
			GameManager.confirmed_card = self.type
			play_confirm()
			Signals.emit_signal(signal_out)
		#don't select card when another card is selected
		elif GameManager.selected_card != null:
			return
		#select card
		else :
			GameManager.selected_card = self.type
			play_select()
			
	#deselect card
	else :
		GameManager.selected_card = null
		play_deselect()

func play_select():
	$DeckAnimationPlayer.play("select")

func play_deselect():
	$DeckAnimationPlayer.play("deselect")
	
func play_confirm():
	%Ground/Mask.visible = true
	%Ground/Sprite2D.visible = true
	$DeckAnimationPlayer.play("confirm")
