extends Button

#@export var main_menu_scene_file: PackedScene;

func _pressed():
	get_tree().paused = false
	to_main_menu()

func to_main_menu():
	get_tree().paused = false
	#var _result = get_tree().change_scene_to_packed(main_menu_scene_file)
	var _result = get_tree().change_scene_to_file("res://menus/main_menu/main_menu.tscn")

