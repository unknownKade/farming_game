extends Node2D

class_name Season

signal end_weather
const next_state = "Environment"

var scenes : Dictionary

func _ready():
	for child in get_children():
		if child is Sprite2D:
			scenes[child.name]= child

func initialize() :
	for scene in scenes :
		scenes[scene].visible = false

func play_entry_animation(weather):
	initialize()
	var scene = scenes.get(weather)
	scene.visible = true
	get_node(GameManger.animation_player).play(weather.to_lower())

func _on_animation_player_animation_finished(anim_name):
	end_weather.emit()
