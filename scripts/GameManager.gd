extends Node

class Crop :
	var name : String
	var level : int
	var state
	
	func _init(name) : 
		self.name = name
		self.level = 1
	
const animation_player = "AnimationPlayer"

var current_round : int = 1
var player_turn = false
var selected_card : Crop
var confirmed_card : Crop
var opponent_card : Crop
var current_environment: String

var p1_deck : Dictionary
var p2_deck : Dictionary

func _ready():
	var crops = ["Beet", "Carrot", "Potato", "Tomato"]
	for crop in crops :
		p1_deck[crop] = Crop.new(crop)
		p2_deck[crop] = Crop.new(crop)
		
	p1_deck["Beet"].level = 3

func get_random_card() -> Crop:
	var live_crops: Array
	
	for crop in p1_deck:
		if p1_deck[crop].level > 0 :
			live_crops.append(p1_deck[crop])
	
	return live_crops[randi_range(0, live_crops.size())]

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
