extends Card

class_name BeetCard

func _ready():
	frame_set = [16,0,4,8,12]
	%Result.return_to_hand.connect(return_card)
	sync_card_level()
