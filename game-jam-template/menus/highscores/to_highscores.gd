extends Button

#@export var highscores_scene_file: PackedScene;

func _pressed():
	to_highscores()

func to_highscores():
	#var _result = get_tree().change_scene_to_packed(highscores_scene_file)
	var _result = get_tree().change_scene_to_file("res://menus/highscores/highscores.tscn")
