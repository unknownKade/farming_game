extends Node

class_name Card
#class extended by card nodes of the current player

signal end_player_phase
signal crop_revived
signal card_return_ended

@onready var sprite: Sprite2D = $Mask/Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var deck_anim_player: AnimationPlayer = $DeckAnimationPlayer
@onready var p1: Node = get_parent()
@onready var player: Node = p1.get_parent()

var level: int = 1
var state: String
var frame_set: Array
var locked: bool = false

func process_click(input) -> void:
	if !player.player_phase or self.locked or p1.played_card or self.level == 0:
		SoundManager.sfx_play(&"click_fail")
		return

	match input :
		0: #left click
			#play current card
			if p1.selected_card == self:
				p1.selected_card = null
				p1.played_card = self
				#p1.played_card.anim_player.queue(str(level))
				p1.played_card.deck_anim_player.queue("select")
				player.assess_played_card()
			#select new card
			elif !p1.selected_card:
				p1.selected_card = self
				deck_anim_player.play("hover")
			#return selected card and select this card
			else:
				p1.selected_card.deck_anim_player.play_backwards("hover")
				p1.selected_card = self
				deck_anim_player.queue("hover")
		1: #right click
			#deselect card
			if p1.played_card:
				p1.played_card = null
		#2: #mouse enter
			#deck_anim_player.queue("hover")
		#3: #mouse out
			#deck_anim_player.play_backwards("hover")

func return_card() -> void:
	p1.played_card = null
	deck_anim_player.queue("return")

func sync_card_level() -> void:
	$Mask/Sprite2D.set_frame(frame_set[level])
#if card is selected play level animation
func play_shake() -> void:
	anim_player.queue("shake")
