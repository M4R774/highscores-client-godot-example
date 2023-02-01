extends Button


func _pressed():
	to_highscores()


func to_highscores():
	var _result = get_tree().change_scene("res://Scenes/highscores.tscn")
