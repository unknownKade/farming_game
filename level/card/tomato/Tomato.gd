extends Card

class_name TomatoCard

func _ready():
	frame_set = [31,0,7,17,24]
	%Result.return_to_hand.connect(return_card)
	sync_card_level()
