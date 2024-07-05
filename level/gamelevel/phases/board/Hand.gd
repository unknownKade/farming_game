extends Node2D

signal card_return_ended
signal confirmed_card

func _ready():
	GameManger.swapped_to_carrot.connect(swap_to_carrot)
	GameManger.swapped_from_carrot.connect(carrot_escape)
	GameManger.confirmed_selected_card.connect(play_confirm_card_animation)
	
	for child in get_children():
		child.confirmed_card.connect(end_board_phase)
		child.card_return_ended.connect(end_return_card)

func carrot_escape():
	GameManger.carrot_escaped = true
	if GameManger.selected_card == null:
		$Carrot.select_card()
		await get_tree().create_timer(1).timeout
	
	$Carrot.deck_anim_player.play("escape")
	GameManger.deselect_card()
	GameManger.player_turn = true
	
func swap_to_carrot():
	%Board.get_node("Timer").stop()
	if GameManger.selected_card == null:
		get_node(GameManger.confirmed_card.name).select_card()
		await get_tree().create_timer(2).timeout
	get_node(GameManger.confirmed_card.name).deselect_card()
	
	await get_tree().create_timer(1).timeout
	$Carrot.select_card()
	await get_tree().create_timer(1).timeout
	$Carrot.confirm_card()
	GameManger.confirmed_card = GameManger.p1_deck['Carrot']
	
func display_cards():
	for card in get_children() :
		card.sync_card_level()
	if GameManger.current_round%4 == 1 and !GameManger.carrot_escaped:
		%HandAnimationPlayer.play("display")

func play_confirm_card_animation():
	get_node(GameManger.confirmed_card.name).confirm_card()
	
func end_board_phase():
	confirmed_card.emit()
	
#after result flip
func return_card(crop : Crop):
	get_node(crop.name).return_card()

#after result phase
func end_return_card():
	card_return_ended.emit()

func _on_dialouge_manager_finished_speech_bubble(crop, event):
	if event == "confirm" :
		get_node(str(crop)).play_this_anim("confirm")
