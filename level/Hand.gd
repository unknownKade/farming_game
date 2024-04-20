extends Node2D

signal player_phase_ended
var hand = {
	"Beet" : preload("res://level/card/beet/Beet.tscn"),
	"Potato" : preload("res://level/card/potato/Potato.tscn"),
	"Carrot" : preload("res://level/card/tomato/Tomato.tscn"),
	"Tomato" : preload("res://level/card/carrot/Carrot.tscn")
}
var coord = [
	{
		"x" = -36,
		"y" = 9,
		"r" = -25
	},
	{
		"x" = -12,
		"y" = 0,
		"r" = -11.6
	},
	{
		"x" = 12,
		"y" = 0,
		"r" = 11.6
	},
	{
		"x" = 36,
		"y" = 9,
		"r" = 25
	}
]
func _ready():
	var i = 0
	for card in hand :
		var instance = hand[card].instantiate()
		instance.position.x = coord[i].x
		instance.position.y = coord[i].y
		instance.rotation_degrees = coord[i].r
		add_child(instance)
		i += 1
		instance.signal_end_turn.connect(confirm_card)

func display_cards():
	for card in hand :
		hand[card].level = GameManger.p1_deck[card].level
		#hand[card].change_texture(hand[card].level)
	
	self.visible = true

func confirm_card():
	if GameManger.opponent_card != null:
		player_phase_ended.emit()
	else :
		GameManger.player_turn = false
