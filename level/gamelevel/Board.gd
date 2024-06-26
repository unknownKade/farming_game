extends State

class_name Board

const next_state = "Garden"
const carrot = "Carrot"

signal player_turn_started

var hand : Dictionary
var is_swap : bool = false

func _ready():
	for child in %Hand.get_children() :
		hand[child.name] = child
		if child.name == carrot :
			child.carrot_escaped.connect(enter)
	
func enter():
	display_cards()
	$Timer.start()
	if !is_swap :
		player_turn_started.emit()
	GameManger.player_turn = true

func display_cards():
	for card in hand :
		hand[card].sync_card_level()
		hand[card].signal_end_turn.connect(end_player_phase)
#TODO : Display cards animation

func _on_timer_timeout():
	if GameManger.selected_card != null :
		hand[GameManger.selected_card.name].visible = false
	GameManger.confirm_card()
	end_player_phase()

func end_player_phase():
	GameManger.player_turn = false
	$Timer.stop()
	
	if is_swap :
		Transition.emit(self, next_state)
	if !is_swap:
		check_carrot_skill(GameManger.confirmed_card, GameManger.opponent_card)

func check_carrot_skill(p1: Crop, p2: Crop):
	var carrot_condition = p1 is Carrot and p1.level > 1 and p2 is Tomato
	var beet_swap_condition = p2 is Beet and GameManger.p1_deck[carrot].level > 1
	
	if !carrot_condition and !beet_swap_condition : 
		Transition.emit(self, next_state)
	elif !p1.skill(p2):
		Transition.emit(self, next_state)
		
	elif beet_swap_condition :
		swap_confirmed_card(hand[carrot])
	else :
		swap_carrot_card()
		
func swap_carrot_card() :
	is_swap = true
	GameManger.nullify_select_and_confirm()
	hand[carrot].run_away()
	
func swap_confirmed_card(card : Card):
	hand[GameManger.confirmed_card.name].deselect()
	GameManger.nullify_select_and_confirm()
	hand[carrot].select_card()
	hand[carrot].confirm_selected_card()
	Transition.emit(self, next_state)
