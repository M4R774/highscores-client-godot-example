extends Button

@export var playername_prompt_path: NodePath
@onready var playername_prompt: Node = get_node(playername_prompt_path)
@export var highscore_manager_path: NodePath
@onready var highscore_manager: Node = get_node(highscore_manager_path)


func _pressed():
	submit()


func submit():
	playername_prompt.visible = false
	highscore_manager.post_highscores_online()
