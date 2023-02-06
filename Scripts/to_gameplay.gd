extends Button


func _ready():
	self.grab_focus()


func _pressed():
	var _result = get_tree().change_scene_to_file("res://Scenes/gameplay.tscn")
