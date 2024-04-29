extends Crop

class_name Carrot

func _init():
	self.name = "Carrot"
	self.level = 1
	self.state = States.NONE
	
func skill(p2 : Crop) -> bool:
	return roll_dice(get_run_probability())
	
func get_run_probability():
	match self.level :
		1 : 
			return 0
		2 : 
			return 0.25
		3 : 
			return 0.5
		4 : 
			return 1
			
