extends State
	
func enter():
	var back = $Back
	var land = $Land
	get_node_and_play(back,GameManger.opponent_card)
	get_node_and_play(land,GameManger.confirmed_card)
	
func get_node_and_play(parent, card):
	var node = parent.get_node(str(card))
	node.visible = true
	parent.get_node(GameManger.animation_player).play(card.to_lower())

