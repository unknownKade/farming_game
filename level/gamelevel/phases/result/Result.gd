extends State

const next_state = "Disaster"

var p1: Node
var p2: Node
var revive_card: Node
var revive_is_p2: bool

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
	
	return 0

func check_beet_revive(is_p1):
	print("checked beet revive skill of " + "player1" if is_p1 else "player2")
	revive_card = p1.revive() if is_p1 else p2.revive()
	
	if revive_card == null:
		print("there are no crops to be revived")
	else:
		print("crop to be revived is " + revive_card.name)
	
	if is_p1 and revive_card != null :
		revive_card.level =1
		revive_is_p2 = true
		
		%Player2.anim_player.play(revive_card.name.to_lower() + "_revive")
		await %Player2.anim_player.animation_finished
	
	if !is_p1 and revive_card != null :
		revive_card.level =1
		revive_card.deck_anim_player.play("revive")
		revive_is_p2 = false
		
func potato_skill(c1, c2) -> int:
	var player_name = "player1" if c1.get_parent() == %Player1 else "player2"
	if c1.state == "ENVY":
		c1.turn_off_buff()
		print(player_name + " potato's envy state has dealt -1lv and state has been removed")
		c1.state = ""
		return -1
	return 0
	
func potato_buff(c1) -> void:
	var player_name = "player1" if c1.get_parent() == %Player1 else "player2"
	match randi_range(0,2):
		0 : 
			c1.state = "ENVY"
			c1.turn_on_buff()
		1 : 
			c1.state = "CARO_PHOBIA"
			c1.get_parent().get_node("Carrot").locked = true
			c1.turn_on_buff()
		2 : 
			c1.state = "FREEZE"
			c1.locked = true
			c1.turn_on_buff()
			
	print(player_name + " potato now has the buff " + c1.state)

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
	
func lift_buff(c1) -> void:
	var player_name = "player1" if c1.get_parent() == %Player1 else "player2"
	if c1.state == "CARO_PHOBIA":
		c1.turn_off_buff()
		c1.get_parent().get_node("Carrot").locked = false
		print(player_name + " potato's CARO-PHOBIA has faded and carrot is unlocked")
	
	if c1.state == "FREEZE":
		c1.turn_off_buff()
		c1.get_parent().get_node("Potato").locked = false
		print(player_name + " potato's buff FREEZE is lifted")
	
	if c1.state == "ENVY":
		c1.turn_off_buff()
		print(player_name + " potato's buff ENVY is lifted")
	c1.state = ""
	
func end_phase() -> void:
	if p1.name == "Beet" and p1.level == 4:
		check_beet_revive(true)
	
	if p2.name == "Beet" and p2.level ==4:
		check_beet_revive(false)
	
	var p1_potato = %Player1.get_node("Potato")
	var p2_potato = %Player2.get_node("Potato")
	
	lift_buff(p1_potato)
	lift_buff(p2_potato)

	if p1.name == "Potato" and p1_potato.level == 2:
		potato_buff(p1_potato)
	if p2.name == "Potato" and p2_potato.level == 2:
		potato_buff(p2_potato)
	
	if revive_card != null:
		if revive_is_p2:
			%Player2.anim_player.play(revive_card.name.to_lower() + "_revive")
			await %Player2.anim_player.animation_finished
		else:
			revive_card.deck_anim_player.play("revive")

	%Player2.sync_card_level()
	%Player2.anim_player.play_backwards(%Player2.played_card.name.to_lower() + "_select")
	
	self.visible = false
	exit()
