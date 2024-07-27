extends Node2D

const frame_set = {
	Crop.potato : [33,0,6,14,25],
	Crop.tomato : [31,0,7,17,24],
	Crop.carrot : [19,0,4,8,15],
	Crop.beet : [16,0,4,8,12]
}

func _ready():
	sync_card_level()

func sync_card_level():
	for child in get_children():
		if child is Node2D :
			var card = GameManger.p2_deck[child.name]
			child.set_frame(frame_set[child.name][card.level])

func start_shake():
	for child in get_children():
		if child is Sprite2D:
			child.start_shake()
			
func select_card(selected_card):
	var anim_name = selected_card.to_lower() + "_select"
	$AnimationPlayer.play(anim_name)
	GameManger.opponent_card = GameManger.p2_deck[selected_card]

func deselect_card(selected_card):
	sync_card_level()
	var anim_name = selected_card.name.to_lower() + "_select"
	$AnimationPlayer.play_backwards(anim_name)
	GameManger.opponent_card = null

func _on_color_rect_signal_click(card):
	select_card(card.name)
