extends Node2D

class_name Winter
signal signal_animation_end()

func _on_animation_player_animation_finished(anim_name):
	signal_animation_end.emit()
