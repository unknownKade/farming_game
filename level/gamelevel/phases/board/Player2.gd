extends Node2D

const frame_set = {
	Crop.potato : [33,0,6,14,25],
	Crop.tomato : [31,0,7,17,24],
	Crop.carrot : [19,0,4,8,15],
	Crop.beet : [16,0,4,8,12]
}

func _ready():
	for child in get_children():
		if child is Sprite2D:
			sync_card_level(child)

func sync_card_level(sprite):
	var card = GameManger.p2_deck[sprite.name]
	sprite.set_frame(frame_set[sprite.name][card.level])

func start_shake():
	for child in get_children():
		if child is Sprite2D:
			child.start_shake()
