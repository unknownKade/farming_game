extends Node2D

signal end_seeding

func play_enviornment():
	self.visible = true
	get_node(GameManger.animation_player).play("rain")

func _on_animation_player_animation_finished(anim_name):
	end_seeding.emit()
