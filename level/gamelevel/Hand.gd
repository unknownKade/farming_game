extends Node2D

signal card_return_ended
signal hand_turn_ended

func _ready():
	%Result.return_to_hand.connect(return_card)
	for child in get_children() :
		child.confirmed_card.connect(end_board_phase)
		child.card_return_ended.connect(end_return_card)

#after board phase
func end_board_phase():
	GameManger.player_turn = false
	hand_turn_ended.emit()

#after result flip
func return_card(crop : Crop):
	get_node(crop.name).return_card()

#after result phase
func end_return_card():
	card_return_ended.emit()
