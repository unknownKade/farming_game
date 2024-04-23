extends Node2D

func _ready():
	%Result.return_to_hand.connect(return_card)

func return_card(crop : Crop):
	get_node(crop.name).return_card()
