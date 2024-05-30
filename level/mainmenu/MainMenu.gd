extends Node2D

const game_path = "res://level/gamelevel/GameLevel.tscn"
const rule_path = "res://level/rule/Rule.tscn"
func _ready():
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file(game_path)

func _on_rule_button_pressed():
	get_tree().change_scene_to_file(rule_path)

func _on_exit_button_pressed():
	get_tree().quit()
