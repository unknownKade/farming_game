extends VBoxContainer

func start_dialouge(crop_name, text):
	$Name.text = crop_name
	$Text.start_typing(text)

func _on_rich_text_label_finished_displaying():
	await get_tree().create_timer(1).timeout
	$NextArrow.blink()
	GameManger.text_typing = false
