extends Crop

class_name Tomato

func _init():
	self.name = "Tomato"
	self.level = 1
	self.state = States.NONE

func skill(p2 : Crop):
	match self.level :
		2 :
			if !(p2 is Tomato) :
				return drain(1)
		3 : 
			return drain(1)
		4 :
			if p2 is Tomato and p2.level == 4 :
				return explode()
			else :
				return drain(2)

func drain(value : int):
	return {
		'p1' : value,
		'p2' : value * -1,
		'skill' : 'drain'
	}

func explode():
	return {
		'p1' : -4,
		'p2' : -4,
		'skill' : 'explode'
	}
