extends State

const next_state = "Result"
var back
var land
var effect
func _ready():
	back = $Back
	land = $Land
	effect = $Effect
	
	effect.end_seeding.connect(end_seeding)
	
func enter():
	play_seeding()

func play_seeding():
	var level = GameManger.confirmed_card.level
	$Card.change_texture(GameManger.confirmed_card.name, level )
	get_node(GameManger.animation_player).play("seeding")

func play_land_animation():
	back.play_land_animation(GameManger.opponent_card.name)
	land.play_land_animation(GameManger.confirmed_card.name)
	await get_tree().create_timer(2).timeout
	get_node(GameManger.animation_player).play("fadeout")

func end_seeding():
	Transition.emit(self, next_state)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seeding" :
		play_land_animation()
	if anim_name == "fadeout" :
		back.visible = false
		land.visible = false
		effect.play_enviornment()
