extends State

const next_state = "Disaster"

var p1: Node
var p2: Node
var revive_card: Node

func _ready():
	pass
	#%Hand.card_return_ended.connect(end_phase)

func enter() -> void:
	p1 = %Player1.played_card
	p2 = %Player2.played_card
	
	environment_affect(GameManger.current_environment)
	card_affect()

func environment_affect(environment) -> void:
	if !(environment == "Rain" and p1.name == "Tomato"):
		p1.level +=1
	if !(environment == "Rain" and p2.name == "Tomato"):
		p2.level +=1

func card_affect() -> void:
	var p1_result:int = 0
	var p2_result:int = 0
	
	match p1.name:
		"Beet": p2_result = p2_result + beet_skill(p1, true)
		"Tomato": p2_result = p2_result + tomato_skill(p1, p2)
		"Potato": p2_result = p2_result + potato_skill(p1, p2)
	
	match p2.name:
		"Beet": p1_result = p1_result + beet_skill(p1, false)
		"Tomato": p1_result = p1_result + tomato_skill(p2, p1)
		"Potato": p1_result = p1_result + potato_skill(p2, p1)

	p1.level += p1_result
	p2.level += p2_result
	
	if p1.level > 4:
		p1.level = 4
	if p1.level < 0:
		p1.level = 0
	if p2.level > 4:
		p2.level = 4
	if p2.level < 0:
		p2.level = 0
	p1.visible = true
	p1.anim_player.play("RESET")
	
	p1.deck_anim_player.queue("flip")

func beet_skill(p1, is_p1) -> int:
	var dead_crops = []
	var opponent: Node
	
	if p1.level < 4:
		return 1
	elif is_p1:
		opponent = %Player2
	else:
		opponent = %Player1
		
	for child in opponent.get_children():
		if child is Node2D and child.level == 0:
			dead_crops.append(child)
	revive_card = dead_crops[randi()%len(dead_crops)]
	
	return 0

func check_beet_revive(is_p1):
	var revived_crop = p1.revive(is_p1) if is_p1 else p2.revive(is_p1)
	
	if is_p1 and revived_crop != null :
		var card = %Hand.get_node(revived_crop.name)
		card.get_node("DeckAnimationPlayer").queue("revive")

	if !is_p1 and revived_crop != null :
		var card = %Player2.get_node(revived_crop.name)
		var animation_player = %Player2.get_node(GameManger.animation_player)
		animation_player.play(revived_crop.name.to_lower() + "_revive")

func potato_skill(c1, c2) -> int:
	if c1.state == "ENVY":
		c1.state = ""
		return -1
	return 0
	
func potato_buff(c1) -> void:
	match randi_range(0,2):
		0 : c1.state = "ENVY"
		1 : c1.state = "CARO_PHOBIA"
		3 : c1.state = "FREEZE"

func tomato_skill(c1, c2) -> int:
	match c1.level:
		2:
			if !(c2.name == "Tomato"):
				return -1
		3: 
			if c2.name == "Potato" and c2.level == 3:
				return 0
			else:
				return -1
		4:
			if c2.name == "Tomato" and c2.level == 4:
				return -4
			elif c2.name == "Potato" and c2.level == 3:
				return -1
			else:
				return -2
	return 0

func end_phase() -> void:
	
	if p1.name == "Beet" and p1.level == 4:
		check_beet_revive(true)
	
	if p2.name == "Beet" and p2.level ==4:
		check_beet_revive(false)

	
	if %Player1.get_node("Potato").level == 2:
		potato_buff(%Player1.get_node("Potato"))
	if %Player2.get_node("Potato").level == 2:
		potato_buff(%Player2.get_node("Potato"))
		
	#%Player1.return_carrot()
	
	%Player2.sync_card_level()
	%Player2/AnimationPlayer.play_backwards(%Player2.played_card.name.to_lower() + "_select")
	
	self.visible = false
	exit()
