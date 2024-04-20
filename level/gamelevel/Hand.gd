extends Node2D

func ready():
	pass
func play_animation():
	for child in self.get_children():
		get_parent().get_node("Result").return_to_hand.connect("play_animation")

func 
