extends Node2D

const frame_set = {
	Crop.potato : [33,0,6,14,25],
	Crop.tomato : [31,0,7,17,24],
	Crop.carrot : [19,0,4,8,15],
	Crop.beet : [16,0,4,8,12]
}

var carrot_return_needed = false
var swapping = false

func _ready():
	GameManger.p2_carrot_action.connect(do_carrot_action)
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
	GameManger.p2_turn = false
	$AnimationPlayer.play(anim_name)
	GameManger.opponent_card = GameManger.p2_deck[selected_card]
	
	if GameManger.p2_carrot_escaped or swapping :
		swapping = false
		%Hand.play_confirm_card_animation()
	elif GameManger.confirmed_card != null :
		GameManger.check_played_cards()

func deselect_card(selected_card):
	sync_card_level()
	var anim_name = selected_card.name.to_lower() + "_select"
	$AnimationPlayer.play_backwards(anim_name)
	
	if GameManger.p2_carrot_escaped :
		carrot_return_needed = true
		GameManger.p2_turn = true

func _on_color_rect_signal_click(card):
	select_card(card)

func do_carrot_action(action):
	if action == Carrot.Action.SWAP :
		swapping = true
		deselect_card(get_node(GameManger.opponent_card.name))

func _on_animation_player_animation_finished(anim_name):
	if carrot_return_needed :
		carrot_return_needed = false
		deselect_card(GameManger.p2_deck[Crop.carrot])
		get_node(Crop.carrot).shivering = true
	elif swapping :
		select_card(Crop.carrot)
		
func hover(crop_name, is_enter) :
	var is_locked = GameManger.p2_deck[crop_name].state == Crop.States.LOCKED
	var anim_name = crop_name.to_lower() + "_hover"
	
	if GameManger.p2_turn and !is_locked and GameManger.opponent_card == null :
		if is_enter :
			%Player2.get_node(GameManger.animation_player).play(anim_name)
		else :
			%Player2.get_node(GameManger.animation_player).play_backwards(anim_name)
