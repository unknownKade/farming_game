extends State

class_name Board

var hand : Dictionary
var is_swap : bool = false

func _ready():
	%Hand.get_node("Carrot").carrot_escaped.connect(enter)

func enter():
	%Hand.confirmed_card.connect(exit)
	%Hand.display_cards()
	GameManger.p1_turn = true
	GameManger.p2_turn = true

