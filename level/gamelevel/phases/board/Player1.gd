extends Node2D

signal card_return_ended
signal confirmed_card

@onready var deck = {
	"Potato" : $Potato,
	"Tomato" : $Tomato,
	"Carrot" : $Carrot,
	"Beet" : $Beet
}

var has_run_away: bool = false
var carrot_swap = false
var carrot_escape = false
var selected_card
var played_card

func _ready():
	%DialougeManager.finished_speech_bubble.connect(after_card_dialouge)

func _on_dialouge_manager_finished_speech_bubble(event) -> void:
	if carrot_escape:
		played_card = null
		$Carrot.deck_anim_player.queue("escape")
		
func escape() -> void:
	selected_card = null
	played_card = null
	$Carrot.deck_anim_player.queue("escape")
func start_shake() -> void:
	for child in get_children():
		child.start_shake()
		child.sync_card_level()
		
func after_card_dialouge(event) -> void:
	if event == "escape":
		played_card.deck_anim_player.queue("escape")
		played_card = null
	else:
		carrot_swap = false
		played_card.deck_anim_player.queue("confirm")
		
func end_result_phase() -> void:
	%Result.end_phase()
