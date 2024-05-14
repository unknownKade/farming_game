extends State

const next_state = "Result"
var back
var land
var effect
func _ready():
	back = $Back
	land = $Land
	effect = $Effect
	
	effect.end_seeding.connect(end_land)

func enter():
	play_land_animation()
	#play_seeding()
	
func play_seeding():
	var card = %Hand.get_node(GameManger.confirmed_card.name)
	var mask = %Hand.get_node("Mask")
	card.reparent(mask)
	card.get_node("DeckAnimationPlayer").play("seeding")

func play_land_animation():
	back.play_land_animation(GameManger.opponent_card.name)
	land.play_land_animation(GameManger.confirmed_card.name)

	await get_tree().create_timer(3).timeout
	effect.play_enviornment()

func end_land() :
	get_node(GameManger.animation_player).play("fadeout")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fadeout" :
		reset(back)
		reset(land)
		Transition.emit(self, next_state)

#this is not done with animation player reset because of jittery results
func reset(node : Node2D):
	node.visible = false
	for child in node.get_children() :
		if child is Sprite2D :
			child.visible = false 
