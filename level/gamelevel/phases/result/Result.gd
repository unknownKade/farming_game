extends State

signal return_to_hand

const next_state = "Disaster"

var p1 : Crop
var p2 : Crop

func _ready():
	%Hand.card_return_ended.connect(end_result)

func enter():
	p1 = GameManger.confirmed_card
	p2 = GameManger.opponent_card
	environment_affect(GameManger.current_environment)
	card_affect()

func play_result_animation():
	%Hand.get_node(p1.name).play_result_animation();

func environment_affect(environment):
	if environment == "Rain" and p1 is Tomato:
		return
	else :
		p1.grow_card(1)
		p2.grow_card(1)

func card_affect():
	p1.skill(p2)
	p2.skill(p1)
	play_result_animation()

func _on_animation_player_animation_finished(anim_name):
	if p1 is Beet and p1.level == 4:
		check_beet_skill()
	end_phase()
	
func end_phase():
	if p1 is Potato :
		check_potato_state()
	
	self.visible = false
	return_to_hand.emit(p1)

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

func end_result():
	if GameManger.carrot_escaped :
		%Carrot.come_back()
	Transition.emit(self, next_state)
