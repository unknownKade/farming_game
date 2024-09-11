extends State

const next_state = "Disaster"

var p1 : Crop
var p2 : Crop

func _ready():
	%Hand.card_return_ended.connect(end_phase)

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
	var p1_result
	var p2_result
	
	if p1 is Beet and p1.level == 4:
		check_beet_skill(true)
	else : 
		p1_result = p1.skill(p2)
		
	if p2 is Beet and p2.level == 4:
		check_beet_skill(false)
	else :
		p2_result = p2.skill(p1)
	
	if p1_result is Dictionary:
		p1.grow_card(p1_result['p1'])
		p2.grow_card(p1_result['p2'])
	if p2_result is Dictionary :
		p2.grow_card(p2_result['p1'])
		p1.grow_card(p2_result['p2'])
	
	play_result_animation()

func end_phase():
	if p1 is Potato :
		check_potato_state()
	if GameManger.p1_carrot_escaped :
		%Carrot.come_back()
		
	%Player2.deselect_card(GameManger.opponent_card)
	
	self.visible = false
	end_result()

func check_beet_skill(is_p1 : bool):
	var revived_crop = p1.revive(is_p1) if is_p1 else p2.revive(is_p1)
	
	if is_p1 and revived_crop != null :
		var card = %Hand.get_node(revived_crop.name)
		card.get_node("DeckAnimationPlayer").queue("revive")

	if !is_p1 and revived_crop != null :
		var card = %Player2.get_node(revived_crop.name)
		var animation_player = %Player2.get_node(GameManger.animation_player)
		animation_player.play(revived_crop.name.to_lower() + "_revive")

func check_potato_state() :
	if p1.state != Crop.States.NONE :
		p1.clear_state()
	elif p1.level == 2 and p1.is_buffable:
		p1.random_debuff()

func end_result():
	Transition.emit(self, next_state)
