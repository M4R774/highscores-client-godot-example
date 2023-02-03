extends Button

export var playername_prompt_path := @""; onready var playername_prompt := get_node(playername_prompt_path) as Node
export var highscore_manager_path := @""; onready var highscore_manager := get_node(highscore_manager_path) as Node


func _pressed():
	playername_prompt.visible = false
	highscore_manager.post_highscores_online()
