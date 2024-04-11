extends State

var cards = ["potato", "tomato", "beet", "carrot"]
var t = "Tomato"
var p = "Potato"
var b = "Beet"
var c = "Carrot"

func enter():
	$Center.result(1,2)

func environment_affect(environment, card):
	if environment == "rain" and card.type != "tomato" :
		return
	else :
		card.level += 1

func card_affect():
	match GameManger.confirmed_card :
		'Tomato' :
			tomato_skill()

func tomato_skill():
	var p1 = GameManger.p1_deck[t]
	var p2 = GameManger.opponent_card
		
	if p1.level == 4 :
		if p2.name == 'Tomato' :
			if p2.level == 4 :
				explode()
			else :
				drain(2)
		
func explode():
	pass
	
func drain(value):
	pass
