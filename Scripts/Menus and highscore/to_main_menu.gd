extends Button


func _pressed():
	get_tree().paused = false
	var _result = get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
