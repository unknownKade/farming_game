extends Node

signal finished_speech_bubble(crop, event)
@onready var dialouge : PackedScene = preload("res://level/dialouge/Dialouge.tscn")

var crop
var event

func make_speech_bubble(crop, event) :
	self.crop = crop
	self.event = event
	
	var speech = dialouge.instantiate()
	speech.setup(crop,event,false)
	speech.position = Vector2(520,300)
	add_child(speech)
	speech.finished_text.connect(emit_next)
	
func emit_next():
	finished_speech_bubble.emit(crop, event)
