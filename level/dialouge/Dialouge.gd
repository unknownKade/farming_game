extends Control

@export var panel: PanelContainer
@export var tail: Control
@export var textbox: VBoxContainer
@export var next_arrow : TextureRect

signal clicked_dialouge
signal finished_text

const color_dictionary = {
	Crop.potato : "009192",
	Crop.tomato : "de0030",
	Crop.carrot : "e05d00",
	Crop.beet : "a049f6",
}

const dialouge_dict = {
	Crop.potato : {
		"rule" : "나는 감자야. 척박한 환경에서도 잘 자라나고, 모든 걸 쉽게 흡수하지. 다른 작물에게 쉽게 영향을 받곤 하지. 난 정말 키우기 쉬워. 나를 먹어줘. * 감자 카드는 어느 환경에서든 무럭무럭 성장합니다. 성장한다면 다른 카드를 따라할 수도 있습니다.",
		"confirm" : "맞아.",
	},
	Crop.tomato : {
		"rule" : "토마토는 나다. 나는 많은 걸 먹어치우지. 맛은 다 똑같아도, 난 언제나 배가 고파. 끊임없이. * 토마토 카드는 상대방의 카드를 잡아먹으며 성장합니다. 같은 턴에 등장한 상대 카드의 레벨이 1 감소합니다.",
		"confirm" : "나, 선택, 현명.",
	},
	Crop.carrot : {
		"rule" : "하하하. 여기서 만나는 건 어색하네. 안 그래? 날 잘 대해 줘. 난 예민해, 섬세하고. 무서우면 도망을 치지. 마치 너처럼 말이야. 안 그런다고? 왜? 그럼 네 걸 내놔. 난 필요하니까.\n참, 난 당근이야. 알려주기 싫었는데, 어쩔 수 없지. * 당근 카드는 주체적으로 활동합니다. 움직일 수단만 생긴다면요.",
		"confirm" : "나 불렀어?",
	},
	Crop.beet : {
		"rule" : "안녕, 나는 비트라고 해. 내가 필요하다면 언제든지 불러 줘. 얼마든지 도울 수 있으니까. * 비트 카드 사용 시 해당 턴에 선택된 상대 카드가 +1 성장합니다.",
		"confirm" : "얼마든지 도와줄게요.",
	},
}

const rule_textbox_size = Vector2(1536- (53 *2) -41, 170)
const game_textbox_size = Vector2(235, 0)

func setup(crop_name, event, is_rule):
	var color = color_dictionary[crop_name]
	
	if is_rule:
		textbox.get_node("Text").set_custom_minimum_size(rule_textbox_size)
	else:
		tail.setup(crop_name, color)
	
	panel.self_modulate = color
	next_arrow.self_modulate = color
	next_arrow.modulate.a = 0
	textbox.start_dialouge(crop_name, dialouge_dict[crop_name][event])

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT :
		if GameManger.text_typing :
			clicked_dialouge.emit()
		else :
			self.queue_free()
			finished_text.emit()
