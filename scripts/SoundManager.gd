extends Node

const path = "res://resource/audio/"
const audio_format = ".wav"

var current_bgm : int = 1

@onready var sound_effects = {
	&"menu_click" : AudioStreamPlayer.new(),
	&"click_fail" : AudioStreamPlayer.new(),
	&"frontback" : AudioStreamPlayer.new(),
	&"weather_side" : AudioStreamPlayer.new(),
}

@onready var bgms = [
	AudioStreamPlayer.new(),
	AudioStreamPlayer.new(),
]

func _ready() :
	for bgm in bgms:
		bgm.finished.connect(play_bgm)
	for i in sound_effects.keys():
		sound_effects[i].stream = load(path + str(i) + ".wav")
		sound_effects[i].bus = &"Sfx"
		add_child(sound_effects[i])
		
	for i in bgms.size():
		bgms[i].stream = load(path + "bgm/" + str(i +1) + ".wav")
		bgms[i].bus = &"Bgm"
		add_child(bgms[i])
	
func sfx_play(sound : StringName) :
	sound_effects[sound].play()
	
func change_bgm():
	var new_bgm = randi_range(0,bgms.size()-1)
	if new_bgm == current_bgm :
		change_bgm()
	else :
		bgms[current_bgm].stop()
		current_bgm = new_bgm
		play_bgm()

func play_bgm():
	bgms[current_bgm].play()

func stop_bgm():
	bgms[current_bgm].stop()
