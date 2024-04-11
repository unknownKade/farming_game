class_name Crop

var name : String
var level : int
var state

const tomato = "Tomato"
const potato = "Potato"
const beet = "Beet"
var carrot = "Carrot"

func grow_card(value : int) :
	self.level += value
	if self.level < 0 :
		self.level = 0
	elif self.level > 4 :
		self.level = 4
