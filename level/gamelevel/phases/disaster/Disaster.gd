extends State

class_name Disaster

const next_state = "Weather"
const result_anim = "after_disaster"
const fade_anim = "after_disaster_fade"

var disasters : Array
var scenes : Dictionary
var current_disaster
var can_click = false
var fading = false

func _ready():
	for child in get_children():
		if child is Sprite2D :
			disasters.append(child.name)
			scenes[child.name] = child

func _input(event):
	if can_click and event is InputEventMouseButton :
		can_click = false
		%HandAnimationPlayer.play(fade_anim)

func enter():
	if GameManger.current_round == 12 or !(is_any_crop_alive(%Player1) and is_any_crop_alive(%Player2)):
		%End.enter()
	elif GameManger.current_round%4 == 0 :
		#get random disaster
		current_disaster = disasters[randi_range(0, disasters.size()-1)]
		scenes[current_disaster].visible = true
		get_node(GameManger.animation_player).play(current_disaster.to_lower())
	else :
		exit()

func _on_level_animation_animation_finished(anim_name):
	match anim_name :
		result_anim : 
			can_click = true
		fade_anim :
			%HandAnimationPlayer.play("RESET")
			for child in  %Player1.get_children():
				child.anim_player.play("RESET")
			exit()

#cards shake after disaster
func _on_animation_player_animation_finished(anim_name):
	disaster_result()
	if current_disaster != null :
		scenes[current_disaster].visible = false
		current_disaster = null
		
	%Player1.start_shake()
	%Player2.start_shake()
	
	await get_tree().create_timer(2).timeout
	%HandAnimationPlayer.play(result_anim)

func disaster_result() -> void:
	for child in %Player1.get_children():
		child.level = child.level - 1
		if child.level <0:
			child.level = 0
	
	for child in %Player2.get_children():
		if child is Node2D :
			child.level = child.level - 1
			if child.level <0:
				child.level = 0

#returns true if at least one crop is alive
func is_any_crop_alive(player: Node) -> bool:
	for child in player.get_children():
		if child is Node2D:
			if child.level > 0:
				return true
	return false
	
