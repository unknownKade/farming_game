extends Node2D

class_name Season

signal end_weather

@export var seasons: Array[Sprite2D]

func enter():
	for season in get_children():
		if season is Node2D:
			season.visible = false
	var current_season = seasons[GameManger.current_round%4 -1]
	current_season.visible = true
	SoundManager.sfx_play(&"weather_side")
	get_node(GameManger.animation_player).play(current_season.name.to_lower())
