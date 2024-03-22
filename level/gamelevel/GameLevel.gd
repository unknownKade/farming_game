extends Node2D

var signal_out = "WeatherPhase"
func _ready():
	Signals.emit_signal(signal_out)
