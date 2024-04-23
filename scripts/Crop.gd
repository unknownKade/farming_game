class_name Crop

var name : String
var level : int = 1
var state : States 
enum States{
	NONE, LOCKED
}

const tomato = "Tomato"
const potato = "Potato"
const beet = "Beet"
var carrot = "Carrot"

func grow_card(value : int) :
	self.level += value
	if self.level < 0 :
		self.state = States.LOCKED
		self.level = 0
	elif self.level > 4 :
		self.level = 4

func roll_dice(probability : float) -> bool:
	return randi() < probability

func lock():
	self.state = States.LOCKED
