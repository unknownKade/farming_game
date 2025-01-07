extends Sprite2D

signal instruction_clicked

func _ready():
	self.visible = false

func _input(event):
	if event is InputEventMouseButton and event.pressed and get_parent().visible :
		get_parent().visible = false
		instruction_clicked.emit()
