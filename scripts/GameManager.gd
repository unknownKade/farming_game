extends Node

signal confirmed_selected_card
signal swapped_to_carrot
signal swapped_from_carrot

const animation_player = "AnimationPlayer"

var current_round : int = 1
var selected_card : Crop
var confirmed_card : Crop
var opponent_card : Crop
var current_environment: String

var player_turn :bool =  false
var carrot_escaped : bool = false

var p1_deck : Dictionary
var p2_deck : Dictionary

func _ready():
	var crops = {
	 	"Beet" : Beet,
		"Carrot" : Carrot,
		"Potato" : Potato,
		"Tomato" : Tomato
	}
	
	for crop in crops :
		p1_deck[crop] = crops[crop].new()
		p2_deck[crop] = crops[crop].new()
	
	p1_deck["Carrot"].level = 4
	
func get_random_card(deck) -> Crop:
	var live_crops: Array
	
	for crop in deck:
		if deck[crop].state != Crop.States.LOCKED :
			live_crops.append(deck[crop])
	
	return live_crops[randi_range(0, live_crops.size() - 1)]

func select_card(card_name : String) :
	selected_card = p1_deck[card_name]

func deselect_card():
	selected_card = null
	confirmed_card = null

func confirm_card() :
	player_turn = false

	if selected_card == null:
		confirmed_card = get_random_card(p1_deck)
	else : 
		confirmed_card = selected_card

	#get player2 card with carrot checked
	get_p2_card(get_random_card(p2_deck))
	check_carrot_skill()

func check_carrot_skill():
	var p1 = confirmed_card
	var p2 = opponent_card
	var carrot_condition = p1 is Carrot and p1.level > 1 and p2 is Tomato
	var beet_swap_condition = p2 is Beet and p1_deck[Crop.carrot].level > 1
	var potato_condition = p1_deck["Potato"].state == Crop.States.PHOBIA

	if !carrot_condition and !beet_swap_condition or potato_condition: 
		confirmed_selected_card.emit(p1)
	elif beet_swap_condition :
		swapped_to_carrot.emit()
	elif !p1.skill(p2):
		confirmed_selected_card.emit(p1)
	else :
		carrot_escaped = true
		swapped_from_carrot.emit()

func p2_result(crop : Crop, value : int, message = null):
	crop.grow_card(value)

func get_p2_card(selected_card : Crop):
	#if !test_crop.is_empty() :
		#opponent_card = p2_deck[test_crop]
	#else :
		opponent_card = selected_card
	
	# check_carrot_skill(opponent_card, confirmed_card) :
	#	Crop.carrot : opponent_card = p2_deck[Crop.carrot]
