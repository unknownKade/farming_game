extends Crop

class_name Carrot

var run_probability : int

func _init():
	self.name = "Carrot"
	self.level = 1
	self.state = States.NONE
	
func skill(p2 : Crop) -> bool:
	if p2 is Tomato or p2 is Beet :
		return roll_dice(run_probability)
	return false
	
func get_run_probability(level) :
	match self.level :
		1 : 
			run_probability = 0
		2 : 
			run_probability = 0.25
		3 : 
			run_probability = 0.5
		4 : 
			run_probability = 1

func lock():
	state = States.LOCKED
