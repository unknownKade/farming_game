extends Node2D
	
func play_seeding():
	var back = $Back
	var land = $Land
	get_node_and_play(land,GameManager.confirmed_card)
	get_node_and_play(back,GameManager.opponent_card)
	
func get_node_and_play(parent, card):
	var node = parent.get_node(card)
	node.visible = true
	parent.get_node(GameManager.animation_player).play(card.to_lower())

