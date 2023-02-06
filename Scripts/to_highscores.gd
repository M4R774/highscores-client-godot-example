extends Button


func _pressed():
	to_highscores()


func to_highscores():
	var _result = get_tree().change_scene_to_file("res://Scenes/highscores.tscn")
