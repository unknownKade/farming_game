extends Node2D

signal end_seeding

func _on_animation_player_animation_finished(anim_name):
	end_seeding.emit()
