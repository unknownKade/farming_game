extends Card

class_name CarrotCard

func _ready():
	frame_set = [19,0,4,8,15]
	%Result.return_to_hand.connect(return_card)
	sync_card_level()

func run_away():
	GameManger.confirmed_card = null
	self.deselect_card()
	self.locked = true
	GameManger.p1_deck[self.name].lock()
