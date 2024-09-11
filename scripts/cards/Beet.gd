extends Crop

class_name Beet

var has_revive = true
var can_have_revive = true

func _init():
	self.name = "Beet"
	self.level = 1
	self.state = States.NONE

func skill(p2 : Crop) :
	if level < 3 or roll_dice(0.5) :
		return {
			'p1' : 0,
			'p2' : 1,
			'skill' : 'grow'
		}
func repleninsh_revive():
	can_have_revive = true

func revive(is_p1) :
	if !has_revive :
		return
	var dead_crops: Array
	var deck = GameManger.p1_deck if is_p1 else GameManger.p2_deck
	
	for crop in deck:
		if deck[crop].level == 0 :
			dead_crops.append(deck[crop])
	
	if dead_crops.is_empty() :
		return
	
	var revived_crop = dead_crops[randi_range(0, dead_crops.size() - 1)]
	#Beet revive
	#print('beet revived ', revived_crop.name)
	#if !is_p1 :
		#GameManger.p2_result(revived_crop, 0, "revive")
	revived_crop.level = 1

	has_revive = false
	can_have_revive = false
	
	return revived_crop
