extends Node

signal p1_carrot_action(result)
signal p2_carrot_action(result)

const animation_player = "AnimationPlayer"

var current_round : int = 1
var selected_card : Crop
var confirmed_card : Crop
var opponent_card : Crop
var current_environment: String

var p1_turn :bool =  false
var p2_turn : bool = false
var p1_carrot_escaped : bool = false
var p2_carrot_escaped : bool = false
var text_typing : bool = false

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
	
func get_random_card(deck) -> Crop:
	var live_crops: Array
	
	for crop in deck:
		if deck[crop].state != Crop.States.LOCKED :
			live_crops.append(deck[crop])
	
	return live_crops[randi_range(0, live_crops.size() - 1)]

func reset():
	deselect_card()
	opponent_card = null
	current_round = 1

func select_card(card_name : String) :
	selected_card = p1_deck[card_name]

func deselect_card():
	selected_card = null
	confirmed_card = null

func play_card(is_p1 : bool) :
	if is_p1 :
		confirmed_card = selected_card
		p1_turn = false
	
	if opponent_card == null or confirmed_card == null :
		return
	else :
		check_played_cards()

# called when both players have chosen cards
func check_played_cards() :
	if p1_deck[Crop.potato].state != Crop.States.PHOBIA :
		if confirmed_card is Carrot and opponent_card is Tomato and confirmed_card.skill(opponent_card):
			p1_carrot_escaped = true
			deselect_card()
			p1_carrot_action.emit(Carrot.Action.ESCAPE)
			return
		elif opponent_card is Beet and p1_deck[Crop.carrot].skill(opponent_card) :
			p1_carrot_action.emit(Carrot.Action.SWAP)
			return

	if p2_deck[Crop.potato].state != Crop.States.PHOBIA :
		if opponent_card is Carrot and confirmed_card is Tomato and opponent_card.skill(confirmed_card) :
			opponent_card = null
			p2_carrot_escaped =true
			p2_carrot_action.emit(Carrot.Action.ESCAPE)
			return
		elif confirmed_card is Beet and p2_deck[Crop.carrot].skill(confirmed_card) :
			p2_carrot_action.emit(Carrot.Action.SWAP)
			return
	
	p2_carrot_action.emit(Carrot.Action.NONE)
	p1_carrot_action.emit(Carrot.Action.NONE)

func p2_result(crop : Crop, value : int, message = null):
	if message == "revive" :
		print("beet used revive on " + crop.name)
		crop.level = 1
	else :
		print(message, " ", crop.name, " by ", value)
		crop.grow_card(value)
		
func new_year():
	current_round += 1
	confirmed_card = null
	selected_card = null
	opponent_card = null
	p1_carrot_escaped = false
	p2_carrot_escaped = false
