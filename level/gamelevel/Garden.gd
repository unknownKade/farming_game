extends State

const next_state = "Result"
const path ="res://resource/images/card/"
const extension = ".png"

func _ready():
	$Effect.end_seeding.connect(end_seeding)

func enter():
	play_seeding()

func play_seeding():
	change_texture(GameManger.confirmed_card, 2)
	get_node(GameManger.animation_player).play("seeding")

func play_land():
	play_seeding()
	var back = $Back
	var land = $Land
	back.visible = true
	land.visible = true
	get_node_and_play(back,GameManger.opponent_card)
	get_node_and_play(land,GameManger.confirmed_card)
	await get_tree().create_timer(2).timeout

	$AnimationPlayer.play("fadeout")

func play_enviornment():
	$Effect.visible = true
	$Effect.get_node("AnimationPlayer").play("rain")
	
func get_node_and_play(parent, card):
	var node = parent.get_node(str(card))
	node.visible = true
	parent.get_node(GameManger.animation_player).play(card.to_lower())

func end_seeding():
	Transition.emit(self, next_state)

func change_texture(card,level):
	var file_name :String = card + str(level)
	$Mask/Card.texture = load(path + file_name + extension)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding" :
		play_land()
	if anim_name == "fadeout" :
		$Land.visible = false
		$Back.visible = false
		play_enviornment()
