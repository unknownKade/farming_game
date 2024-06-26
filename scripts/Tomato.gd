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
				drain(p2, 1)
		3 : 
			drain(p2, 1)
		4 :
			if p2 is Tomato and p2.level == 4 :
				explode(p2)
			else :
				p2.grow_card(-2)

func drain(p2 : Crop, value : int):
	grow_card(1)
	GameManger.p2_result(p2, 1, "drain")

func explode(p2 : Crop):
	grow_card(-4)
	GameManger.p2_result(p2, -4, "explode")
