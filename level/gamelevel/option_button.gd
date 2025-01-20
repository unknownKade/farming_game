extends TextureButton

const route = "res://resource/images/game_level/menu_button/sound"
const extension = ".png"
var volumes = [0, -6, -24, -80]
var index = 0
var lower_volume = true
func _pressed():
	var bus_index = AudioServer.get_bus_index("Master")
	
	if index >= len(volumes)-1:
		lower_volume = false
	
	if index < 1:
		lower_volume = true
	
	if lower_volume:
		index += 1
	else:
		index -= 1
		
	AudioServer.set_bus_volume_db(bus_index, volumes[index])
	var number = index + 1
	
	self.texture_normal = load(route + str(number) + extension)
	self.texture_hover = load(route + "_pressed" + str(number) + extension)
	
