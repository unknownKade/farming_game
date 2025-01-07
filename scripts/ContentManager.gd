extends Node

signal dialouge_finished

const menu_scene_path : PackedScene = preload("res://level/mainmenu/MainMenu.tscn")
#const menu_scene_path : String = "res://level/mainmenu/MainMenu.tscn"
const rule_scene_path : String = "res://level/rule/Rule.tscn"
const game_scene_path : String = "res://level/gamelevel/GameLevel.tscn"

#@onready var gamelevel:Node = get_node("/root/GameLevel")
const file_path = "res://resource/dialouge.json"
const color_dictionary = {
	"Potato" : "009192",
	"Tomato" : "de0030",
	"Carrot" : "e05d00",
	"Beet" : "a049f6",
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

func to_home():
	GameManger.current_round = 1
	get_tree().get_root().get_node("GameLevel").reset()
	
	SoundManager.stop_bgm()
	get_tree().change_scene_to_packed(menu_scene_path)
