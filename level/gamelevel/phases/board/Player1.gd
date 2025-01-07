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

#carrot escape
#swap to carrot
#confirm card -> seeding
#return card -> after results

func _ready():
	%DialougeManager.finished_speech_bubble.connect(after_card_dialouge)

func _on_dialouge_manager_finished_speech_bubble(event) -> void:
	if carrot_swap:
			played_card = null
			$Carrot.deck_anim_player.queue("return")
	elif carrot_escape:
		played_card = null
		$Carrot.deck_anim_player.queue("escape")
	
func lock_cards(is_locked) -> void:
	for child in get_children():
		child.locked = is_locked
		
func escape_or_swap(is_escape) -> void:
	played_card = null
	selected_card = null
	var anim_name = "escape" if is_escape else "return"
	$Carrot.deck_anim_player.queue(anim_name)

func card_dialouge(dialouge_event) -> void:
	%DialougeManager.make_speech_bubble(self.name, dialouge_event)

func after_card_dialouge(event) -> void:
	if event == "swap":
		played_card.deck_anim_player.queue("swap")
		played_card = null
	elif event == "escape":
		played_card.deck_anim_player.queue("escape")
		played_card = null
	else:
		played_card.deck_anim_player.queue("confirm")
		
func end_result_phase() -> void:
	%Result.end_phase()
