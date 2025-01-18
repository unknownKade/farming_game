extends State

class_name Player

@onready var p1:Node =  $Player1
@onready var p2:Node = $Player2
@onready var animPlayer:AnimationPlayer = $HandAnimationPlayer
var player_phase:bool = false
enum Action{
	NONE, ESCAPE, SWAP
}

var carrot_prob = [0, 0, 0.25, 0.5, 1]

func enter() -> void:	#if spring display_cards
	if GameManger.current_round%4 == 1:
		display_cards()
	player_phase = true
	if GameManger.random_ai:
		%RandomAI.choose_card()

func _ready():
	for child in p1.get_children():
		child.end_player_phase.connect(exit)

func display_cards() -> void:
	%Player2.sync_card_level()
	for child in p1.get_children():
		child.sync_card_level()
	%HandAnimationPlayer.play("display")

#return carrot
func return_carrot() -> void:
	if p1.has_run_away:
		p1.return_carrot()
	elif p2.has_run_away:
		pass

#check whether both players have played a card
func assess_played_card() -> void:
	if !p1.played_card or !p2.played_card:
		return
	var p1_escape = p1.played_card.name == "Carrot" and p1.played_card.level > 1 and !is_there_only_carrot(%Player1) and p2.played_card.name == "Tomato" and roll_dice(carrot_prob[p1.played_card.level])
	var p2_escape = p2.played_card.name == "Carrot" and p2.played_card.level > 1 and !is_there_only_carrot(%Player2) and p1.played_card.name == "Tomato" and roll_dice(carrot_prob[p2.played_card.level])
	var p1_swap = p1.played_card.name != "Carrot" and p1.get_node("Carrot").level > 1 and p2.played_card.name == "Beet" and roll_dice(carrot_prob[p1.get_node("Carrot").level])
	var p2_swap = p2.played_card.name != "Carrot" and p2.get_node("Carrot").level > 1 and p1.played_card.name == "Beet" and roll_dice(carrot_prob[p2.get_node("Carrot").level])
	
	if p1_escape:
		print("player1's carrot escaped")
		p1.escape()
		return
	elif p1_swap:
		print("player1's carrot swapped places")
		p1.carrot_swap = true
		if p1.played_card.deck_anim_player.is_playing():
			await p1.played_card.deck_anim_player.animation_finished
		p1.played_card.deck_anim_player.queue("return")
		p1.played_card = p1.get_node("Carrot")
		p1.played_card.deck_anim_player.queue("select")
		await p1.played_card.deck_anim_player.animation_finished
		
	if p2_escape:
		print("player2's carrot escaped")
		p2.escape()
		if GameManger.random_ai:
			%RandomAI.choose_card()
		return
	elif p2_swap:
		print("player2's carrot swapped places")
		p2.carrot_swap = true
		p2.anim_player.play_backwards(p2.played_card.name.to_lower() + "_select")
		
		p2.played_card = p2.get_node("Carrot")
		p2.anim_player.queue("carrot_select")
		await p2.anim_player.animation_finished
		
	player_phase = false
	var dialouge_event = "select"
	
	if p1.carrot_swap:
		dialouge_event = "swap"
	elif p1.carrot_escape:
		dialouge_event = "escape"
	
	if p1.played_card.deck_anim_player.is_playing():
		await p1.played_card.deck_anim_player.animation_finished
	%DialougeManager.make_speech_bubble(p1.played_card.name, p1.played_card.level, dialouge_event)
	
func roll_dice(probability : float) -> bool:
	return randf() < probability

func is_there_only_carrot(player: Node) -> bool:
	for child in player.get_children():
		if child is Node2D:
			if child.name != "Carrot" and child.level > 0:
				return false
	return true
