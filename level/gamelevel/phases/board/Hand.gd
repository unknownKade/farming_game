extends Node2D

signal card_return_ended
signal confirmed_card

func _ready():
	GameManger.p1_carrot_action.connect(do_carrot_action)
	for child in get_children():
		child.confirmed_card.connect(end_board_phase)
		child.card_return_ended.connect(end_return_card)

func display_cards():
	for card in get_children() :
		card.sync_card_level()
	if GameManger.current_round%4 == 1 and !GameManger.p1_carrot_escaped:
		%HandAnimationPlayer.play("display")

func do_carrot_action(action):
	if action == Carrot.Action.ESCAPE :
		carrot_escape()
	elif action == Carrot.Action.SWAP :
		swap_to_carrot()
	else :
		get_node(GameManger.confirmed_card.name).card_dialouge("select")

func carrot_escape():
	GameManger.p1_carrot_escaped = true
	if GameManger.selected_card == null:
		$Carrot.select_card()
		await get_tree().create_timer(1).timeout
	
	$Carrot.deck_anim_player.play("escape")
	GameManger.deselect_card()
	GameManger.p1_turn = true
	
func swap_to_carrot():
	if GameManger.selected_card == null:
		get_node(GameManger.confirmed_card.name).select_card()
		await get_tree().create_timer(2).timeout
	get_node(GameManger.confirmed_card.name).deselect_card()
	
	await get_tree().create_timer(1).timeout
	$Carrot.select_card()
	await get_tree().create_timer(1).timeout
	$Carrot.card_dialouge("swap")
	GameManger.confirmed_card = GameManger.p1_deck['Carrot']

func play_confirm_card_animation():
	get_node(GameManger.confirmed_card.name).card_dialouge("select")
	
func end_board_phase():
	confirmed_card.emit()
	
#after result flip
func return_card(crop : Crop):
	get_node(crop.name).return_card()

#after result phase
func end_return_card():
	card_return_ended.emit()

func _on_dialouge_manager_finished_speech_bubble(crop, event):
	if event == "select" :
		get_node(str(crop)).play_this_anim("confirm")
