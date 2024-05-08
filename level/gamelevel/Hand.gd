extends Node2D

signal returned_card

func _ready():
	%Result.return_to_hand.connect(return_card)

func return_card(crop : Crop):
	get_node(crop.name).return_card()
	returned_card.emit()
