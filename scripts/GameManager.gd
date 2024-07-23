extends Node

signal confirmed_selected_card
signal swapped_to_carrot
signal swapped_from_carrot
signal dialouge_finished

const animation_player = "AnimationPlayer"

const file_path = "res://resource/dialouge.json"
var current_round : int = 1
var selected_card : Crop
var confirmed_card : Crop
var opponent_card : Crop
var current_environment: String

var player_turn :bool =  false
var carrot_escaped : bool = false
var text_typing : bool = false

var p1_deck : Dictionary
var p2_deck : Dictionary
var dialouge_dict

func _ready():
	var crops = {
	 	"Beet" : Beet,
		"Carrot" : Carrot,
		"Potato" : Potato,
		"Tomato" : Tomato
	}
	dialouge_dict = load_json_file(file_path)
	
	for crop in crops :
		p1_deck[crop] = crops[crop].new()
		p2_deck[crop] = crops[crop].new()
		
func load_json_file(path: String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var text = dataFile.get_as_text()
		var parsedResult = JSON.parse_string(text)
		
		if parsedResult is Dictionary :
			return parsedResult
		else:
			print("parsing file error")
	else:
		print("file doesn't exist")
		
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
	check_carrot_skill(true).emit()
		
func check_carrot_skill(is_host :bool):
	var p1  = confirmed_card if is_host else opponent_card
	var p2 = opponent_card if is_host else confirmed_card
	var deck = p1_deck if is_host else p2_deck
	var carrot_condition = p1 is Carrot and p1.level > 1 and p2 is Tomato
	var beet_swap_condition = !(p1 is Carrot) and p2 is Beet and deck[Crop.carrot].level > 1
	var potato_condition = deck["Potato"].state == Crop.States.PHOBIA

	if !carrot_condition and !beet_swap_condition or potato_condition: 
		return confirmed_selected_card
	elif beet_swap_condition :
		return swapped_to_carrot
	elif !p1.skill(p2):
		return confirmed_selected_card
	else :
		return swapped_from_carrot

func p2_result(crop : Crop, value : int, message = null):
	if message == "revive" :
		print("beet used revive on " + crop.name)
		crop.level = 1
	else :
		print(message, " ", crop.name, " by ", value)
		crop.grow_card(value)

func get_p2_card(p2 : Crop):
	opponent_card = p2
	check_carrot_skill(false)
	
	match check_carrot_skill(false) :
		swapped_from_carrot :
			p2_deck[Crop.carrot].state = Crop.States.LOCKED
			opponent_card = get_random_card(p2_deck)
		swapped_to_carrot :
			opponent_card = p2_deck[Crop.carrot]

func dialouge_manager():
	dialouge_finished.emit()
	
func disaster_result():
	for crop in p1_deck:
		p1_deck[crop].grow_card(-1)
	for crop in p2_deck:
		p2_deck[crop].grow_card(-1)
