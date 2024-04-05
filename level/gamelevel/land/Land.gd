extends Node2D

func _ready():
	self.visible = false

func play_land_animation(card : String):
	self.visible = true
	get_node(str(card)).visible = true
	get_node(GameManger.animation_player).play(card.to_lower())
