extends Node2D

func _ready():
	pass

func _on_start_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	$Background/Title.visible = false
	$Background/ButtonContainer.visible = false
	$Background/ButtonContainer2.visible = true

func _on_rule_button_pressed():
	SoundManager.sfx_play(&"menu_click")
	get_tree().change_scene_to_file(ContentManager.rule_scene_path)

func _on_exit_button_pressed():
	SoundManager.sfx_play(&"menu_click")


func _on_p1_button_pressed() -> void:
	get_tree().change_scene_to_file(ContentManager.game_scene_path)
