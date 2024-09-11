extends Node2D

signal end_seeding

func ready():
	$AnimationPlayer.play("music")

func play_environment():
	if GameManger.current_environment == "Music" :
		SoundManager.change_bgm()
		await get_tree().create_timer(3).timeout
		reset()
	else :
		get_node(GameManger.current_environment).visible = true
		get_node(GameManger.animation_player).play(GameManger.current_environment.to_lower())

func _on_animation_player_animation_finished(anim_name):
	reset()

func reset():
	get_node(GameManger.current_environment).visible = false
	end_seeding.emit()
