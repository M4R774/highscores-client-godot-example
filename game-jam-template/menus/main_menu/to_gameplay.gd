extends Button

#@export var scene_file: PackedScene;

func _ready():
	self.grab_focus()

func _pressed():
	#var _result = get_tree().change_scene_to_packed(scene_file)
	var _result = get_tree().change_scene_to_file("res://levels/gameplay/gameplay.tscn")
