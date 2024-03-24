extends Node2D

class_name Beet

const signal_out = "PlayerEnd"
func _on_area_2d_signal_card_change(is_select):
	if is_select :
		if GameManager.selected_card == self :
			GameManager.confirmed_card = self
			play_confirm()
			Signals.emit_signal(signal_out)
		else :
			GameManager.selected_card = self
			play_select()
			
	else :
		GameManager.selected_card = null
		play_deselect()

func play_select():
	$DeckAnimationPlayer.play("select")

func play_deselect():
	$DeckAnimationPlayer.play("deselect")
	
func play_confirm():
	$DeckAnimationPlayer.play("confirm")
