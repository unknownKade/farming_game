extends State

var next_state = "Hand"
signal return_to_hand
var p1 : Crop
var p2 : Crop

func enter():
	p1 = GameManger.confirmed_card
	p2 = GameManger.opponent_card
	var old_level = p1.level
	environment_affect(GameManger.current_environment)
	card_affect(old_level)

func play_result_animation(old_level, new_level):
	$Center.result(old_level, new_level)

func environment_affect(environment):
	if environment == "Rain" and p1 is Tomato:
		return
	else :
		p1.grow_card(1)

func card_affect(old_level : int):
	p1.skill(p2)
	play_result_animation(old_level, p1.level)

func _on_animation_player_animation_finished(anim_name):
	self.visible = false
	GameManger.selected_card = null
	return_to_hand.emit()
	#Transition.emit(self, next_state)
