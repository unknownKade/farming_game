extends Node2D

var card : String

func play_land_animation(card : String):
	self.visible = true
	self.card = card.to_lower()
	get_node(card).visible = true
	get_node(GameManger.animation_player).play("fadein")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fadein" :
		get_node(GameManger.animation_player).play(card)
