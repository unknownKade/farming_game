extends State

var next_state = "Disaster"
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
	if p1 is Beet and p1.level == 4:
		check_beet_skill()
	end_phase()
	
func end_phase():
	if p1 is Potato :
		check_potato_state()
	
	self.visible = false
	GameManger.selected_card = null
	return_to_hand.emit(p1)
	Transition.emit(self, next_state)

func check_beet_skill():
	var revived_crop = p1.revive()
	if revived_crop != null :
		var card = %Hand.get_node(revived_crop.name)
		card.get_node("DeckAnimationPlayer").play("revive")
		card.crop_revived.connect(end_phase)

func check_potato_state() :
	if p1.state != Crop.States.NONE :
		p1.clear_state()
	elif p1.level == 2 and p1.is_buffable:
		p1.random_debuff()
