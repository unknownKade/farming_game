extends Node2D

var current_phase : int = 1

func _ready():
	$Weather.draw_weather_card(current_phase)
