extends Node2D

class_name Card

signal confirmed_card 	#signal to Board
signal crop_revived
signal card_return_ended

var level : int
var locked : bool
var frame_set : Array
var sprite : Sprite2D
var anim_player : AnimationPlayer
var deck_anim_player : AnimationPlayer

func process_click(is_left_click):
	get_node(GameManger.animation_player).stop() 

	if GameManger.text_typing == true or locked :
		return

	if is_left_click:
		#select new card
		if GameManger.selected_card == null :
			select_card()
		elif GameManger.selected_card.name == self.name :
			#play card after carrot runs away
			if GameManger.p1_carrot_escaped :
				card_dialouge("select")
				GameManger.confirmed_card = GameManger.p1_deck[self.name]
			#play card and end turn
			else :
				GameManger.confirmed_card = GameManger.selected_card
				GameManger.play_card(true)
		#clicked somewhere else
		else :
			return
	#right click anywhere deselect
	elif GameManger.selected_card != null :
		deselect_card()

func sync_card_level():
	var card = GameManger.p1_deck[self.name]
	self.level = card.level
	if card.level == 0 or card.state == Crop.States.LOCKED :
		self.locked = true
		
	$Mask/Sprite2D.set_frame(frame_set[level])
	$Mask.signal_click.connect(process_click)

func card_dialouge(dialouge_event):
	var dialougeManger = get_parent().get_parent().get_node("DialougeManager")
	dialougeManger.make_speech_bubble(self.name, dialouge_event)

func select_card():
	GameManger.select_card(self.name)
	deck_anim_player.play("select")
	anim_player.play(str(level))

func deselect_card():
	GameManger.deselect_card()
	deck_anim_player.play("deselect")

func play_result_animation():
	anim_player.play("RESET")
	deck_anim_player.play("flip");

func return_card():
	if self.name == GameManger.confirmed_card.name :
		deck_anim_player.play("return")

func play_this_anim(anim_name):
	deck_anim_player.play(anim_name)
