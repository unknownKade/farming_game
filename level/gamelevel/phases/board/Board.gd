extends State

class_name Board

const next_state = "Garden"

var hand : Dictionary
var is_swap : bool = false
@export var timer : Node

func _ready():
	%Hand.get_node("Carrot").carrot_escaped.connect(enter)

func enter():
	%Hand.confirmed_card.connect(exit)
	%Hand.display_cards()
	GameManger.p1_turn = true
	GameManger.p2_turn = true

func exit():
	Transition.emit(self, next_state)
