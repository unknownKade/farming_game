extends Node

signal triggered_swap_card

const animation_player = "AnimationPlayer"

var current_round : int = 1
var player_turn = false
var selected_card : Crop
var confirmed_card : Crop
var opponent_card : Crop
var current_environment: String
var carrot_escaped : bool

var p1_deck : Dictionary
var p2_deck : Dictionary
@export_range(0,4) var potato_lv : int = 1
@export_range(0,4) var beet_lv : int = 1
@export_range(0,4) var tomato_lv : int = 1
@export_range(0,4) var carrot_lv : int = 1
@export_range(0,4) var p2_potato_lv : int = 1
@export_range(0,4) var p2_beet_lv : int = 1
@export_range(0,4) var p2_tomato_lv : int = 1
@export_range(0,4) var p2_carrot_lv : int = 1

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
		
	p1_deck["Potato"].level = potato_lv
	p1_deck["Beet"].level = beet_lv
	p1_deck["Tomato"].level = tomato_lv
	p1_deck["Carrot"].level = carrot_lv
	p2_deck["Potato"].level = p2_potato_lv
	p2_deck["Beet"].level = p2_beet_lv
	p2_deck["Tomato"].level = p2_tomato_lv
	p2_deck["Carrot"].level = p2_carrot_lv
	
func get_random_card() -> Crop:
	var live_crops: Array
	
	for crop in p1_deck:
		if p1_deck[crop].state != Crop.States.LOCKED :
			live_crops.append(p1_deck[crop])
	
	return live_crops[randi_range(0, live_crops.size() - 1)]

func select_card(card_name : String) :
	selected_card = p1_deck[card_name]

func deselect_card():
	selected_card = null

func confirm_card() :
	if confirmed_card != null:
		return

	if selected_card == null:
		confirmed_card = get_random_card()
	else : 
		confirmed_card = selected_card

func p2_result(crop : Crop, value : int, message = null):
	crop.grow_card(value)
	print(message)

func swap_card():
	triggered_swap_card.emit()

func nullify_select_and_confirm():
	selected_card = null
	confirmed_card = null
