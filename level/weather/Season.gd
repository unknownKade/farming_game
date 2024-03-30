extends Node2D

class_name Season

signal end_weather
const next_state = "Environment"

var scenes : Dictionary

func _ready():
	for child in get_children():
		scenes[child.name]= child

func play_entry_animation(weather):
	var scene = scenes.get(weather)
	scene.visible = true
	get_node(GameManger.animation_player).current_season = weather

func _on_animation_player_animation_finished(anim_name):
	get_node(GameManger.animation_player).current_season = ""
	end_weather.emit()
