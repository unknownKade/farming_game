extends Node2D

var signal_in = "ResultPhase"
var signal_out = "WeatherPhase"

func _ready():
	Signals.connect(signal_in, calculate_result)
	Signals.emit_signal(signal_out)

func calculate_result():
	$Garden.play_seeding()
