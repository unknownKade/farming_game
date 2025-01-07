extends Crop

class_name Carrot

enum Action {
	NONE, ESCAPE, SWAP
}

func _init():
	self.name = "Carrot"
	self.level = 1
	self.state = States.NONE
	
func skill(p2 : Crop) -> bool:
	if level >1 and p2 is Tomato :
		return roll_dice(get_run_probability())
	if level >1 and p2 is Beet :
		return roll_dice(get_run_probability())
	else :
		return false
	
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
			
