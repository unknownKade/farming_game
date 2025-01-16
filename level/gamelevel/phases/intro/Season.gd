extends Node2D

class_name Season

signal end_weather

@export var seasons: Array[Sprite2D]
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
var current_season

func enter() -> void:
	for season in get_children():
		if season is Node2D:
			season.visible = false
	
	current_season = seasons[GameManger.current_round%4 -1]
	current_season.visible = true
	anim_player.play(current_season.name.to_lower())
	$Timer.start(randi_range(5,10))

func _on_timer_timeout() -> void:
	anim_player.play(current_season.name.to_lower())
	$Timer.start(randi_range(5,10))
