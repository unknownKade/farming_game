extends CanvasLayer

signal instruction_clicked

var first_time = true

func _ready():
	self.visible = false

func _input(event):
	if first_time and event is InputEventMouseButton and event.pressed and visible :
		first_time = false
		visible = false
		instruction_clicked.emit()
