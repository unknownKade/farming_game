extends Node

signal dialouge_finished

@export var menu_scene_path : String = "res://level/mainmenu/MainMenu.tscn"
const file_path = "res://resource/dialouge.json"
const color_dictionary = {
	Crop.potato : "009192",
	Crop.tomato : "de0030",
	Crop.carrot : "e05d00",
	Crop.beet : "a049f6",
}

var dialouge_dict

func _ready():
	dialouge_dict = load_json_file(file_path)

func load_json_file(path: String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var text = dataFile.get_as_text()
		var parsedResult = JSON.parse_string(text)
		
		if parsedResult is Dictionary :
			return parsedResult
		else:
			print("parsing file error")
	else:
		print("file doesn't exist")

func dialouge_manager():
	dialouge_finished.emit()

