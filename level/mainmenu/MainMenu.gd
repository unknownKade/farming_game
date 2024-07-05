extends Node2D

@export var game_scene : PackedScene
@export var rule_scene : PackedScene

func _ready():
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(game_scene)

func _on_rule_button_pressed():
	get_tree().change_scene_to_packed(rule_scene)

func _on_exit_button_pressed():
	get_tree().quit()
