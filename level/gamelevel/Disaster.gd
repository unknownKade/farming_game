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
	if can_click and event is InputEventMouseButton:
		%LevelAnimation.play(fade_anim)

func enter():
	if GameManger.current_round%4 == 0 :
		#get random disaster
		current_disaster = disasters[randi_range(0, disasters.size()-1)]
		scenes[current_disaster].visible = true
		get_node(GameManger.animation_player).play(current_disaster.to_lower())
	else :
		end_round()

func end_round():
	Transition.emit(self, next_state)

func _on_level_animation_animation_finished(anim_name):
	match anim_name :
		result_anim : 
			can_click = true
		fade_anim :
			%LevelAnimation.play("RESET")
			end_round()

#cards shake after disaster
func _on_animation_player_animation_finished(anim_name):
	for child in %Hand.get_children() :
		child.get_node("Mask").get_node("Sprite2D").start_shake()
	await get_tree().create_timer(2).timeout
	
	%HandAnimationPlayer.play(result_anim)
