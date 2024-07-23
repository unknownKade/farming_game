extends Crop

class_name Beet

var has_revive = true
var can_have_revive = true

func _init():
	self.name = "Beet"
	self.level = 1
	self.state = States.NONE

func skill(p2 : Crop):
	if level == 4 :
		revive()
	elif level != 3 or roll_dice(0.5) :
		grow_opponent(p2)

func grow_opponent(p2 : Crop):
	GameManger.p2_result(p2, 1, "grow")

func repleninsh_revive():
	can_have_revive = true

func revive() :
	if !has_revive :
		return
	
	var dead_crops: Array
	
	for crop in GameManger.p2_deck:
		if GameManger.p2_deck[crop].level == 0 :
			dead_crops.append(GameManger.p2_deck[crop])
	
	if dead_crops.is_empty() :
		return
	
	var revived_crop = dead_crops[randi_range(0, dead_crops.size() - 1)]
	
	GameManger.p2_result(revived_crop.name, 0, "revive")

	has_revive = false
	can_have_revive = false
	
	return revived_crop
