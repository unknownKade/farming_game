extends Crop

class_name Potato

var is_buffable = true

func _init():
	self.name = "Potato"
	self.level = 1
	self.state = States.NONE

func skill(p2 : Crop):
	if state == States.ENVY :
		GameManger.p2_result(p2, -1, "attack")

func clear_state():
	self.state = States.NONE

func random_debuff():
	match randi_range(0,2):
		0 : state = States.ENVY
		1 : state = States.PHOBIA
		3 : state = States.LOCKED
	
	is_buffable = false
