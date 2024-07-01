extends RichTextLabel

@export var typing_time : float = 0.1

var dialouge = ""
var letter_index = 0

signal finished_displaying()

func start_typing(dialouge):
	self.dialouge = dialouge
	GameManger.text_typing = true
	type_dialouge()

func type_dialouge():
	text += dialouge[letter_index]
	letter_index +=1
	
	if letter_index >= dialouge.length():
		stop_typing()
	
	$TextTimer.autostart = true
	await resized

func _on_timer_timeout():
	type_dialouge()
	
func _on_dialouge_clicked_dialouge():
	stop_typing()

func stop_typing():
	text = dialouge
	$TextTimer.stop()
	GameManger.text_typing = false
	finished_displaying.emit()
	return
