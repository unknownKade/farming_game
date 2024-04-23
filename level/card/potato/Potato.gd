extends Card

class_name PotatoCard

func _ready():
	frame_set = [33,0,6,14,25]
	%Result.return_to_hand.connect(return_card)
	sync_card_level()

