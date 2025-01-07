extends Node2D

const frame_set = {
	"Potato" : [33,0,6,14,25],
	"Tomato" : [31,0,7,17,24],
	"Carrot" : [19,0,4,8,15],
	"Beet" : [16,0,4,8,12]
}

@onready var player = get_parent()
var carrot_ran: bool = false
var selected_card: Node
var played_card: Node

func _ready():
	for child in get_children():
		if child is Node2D:
			child.get_node("ColorRect").signal_click.connect(process_click)

func sync_card_level():
	for child in get_children():
		if child is Node2D :
			child.set_frame(frame_set[child.name][child.level])

func start_shake():
	for child in get_children():
		if child is Sprite2D:
			child.start_shake()

#func deselect_card(selected_card):
	#sync_card_level()
	#var anim_name = selected_card.name.to_lower() + "_select"
	#$AnimationPlayer.play_backwards(anim_name)

#func _on_animation_player_animation_finished(anim_name):
	#if carrot_ran:
		#carrot_ran = false
		#deselect_card(GameManger.p2_deck[Crop.carrot])
		#get_node(Crop.carrot).shivering = true

func hover(crop_name, is_enter) :
	var is_locked = false
	var anim_name = crop_name.to_lower() + "_hover"
	
	if GameManger.p2_turn and !is_locked and GameManger.opponent_card == null :
		if is_enter :
			$AnimationPlayer.queue(anim_name)
		else :
			await $AnimationPlayer.animation_finished
			$AnimationPlayer.play_backwards(anim_name)

func process_click(crop:Node) -> void:
	if !player.player_phase or played_card:
		SoundManager.sfx_play(&"click_fail")
		return
	var anim_name = crop.name.to_lower() + "_hover"
	
	if !selected_card:
		$AnimationPlayer.queue(anim_name)
		selected_card = crop
	elif selected_card == crop:
		played_card = selected_card
		selected_card = null
		$AnimationPlayer.queue(crop.name.to_lower() + "_select")
		player.assess_played_card()
	elif !played_card:
		$AnimationPlayer.play_backwards(selected_card.name.to_lower() + "_hover")
		$AnimationPlayer.queue(anim_name)
		selected_card = crop
