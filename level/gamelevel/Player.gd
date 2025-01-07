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

func _ready():
	for child in p1.get_children():
		child.end_player_phase.connect(exit)

func display_cards() -> void:
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
	
	if p1.played_card.name == "Carrot":
		var action = carrot_action(p1.played_card, p2.played_card)
		if action != Action.NONE:
			p1.escape_or_swap(action)
			return
		
	if p2.played_card.name == "Carrot":
		var action = carrot_action(p2.played_card, p1.played_card)
		if action != Action.NONE:
			p2.escape_or_swap(action)
			return
	
	player_phase = false
	#seeding and dialouge
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

func carrot_action(card1, card2) -> Action:
	if card1.name != "Carrot" or card1.level < 2 :
		return Action.NONE
	
	if card2.name == "Tomato" and roll_dice(carrot_prob[card1.level]) :
		return Action.ESCAPE
	
	if card2.name == "BEET" and roll_dice(carrot_prob[card1.level]):
		return Action.SWAP
		
	return Action.NONE
