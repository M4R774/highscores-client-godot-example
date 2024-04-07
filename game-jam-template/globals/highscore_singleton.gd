extends Node2D

var PLAYER_NAME = null
var SCORE = null

var GAME_NAME : String = ""
var LOCAL_HIGHSCORES : Array = []


func _ready():
	load_highscores_from_disk()
	GAME_NAME = ProjectSettings.get_setting('application/config/name')
	assert(GAME_NAME != "")


func score_is_high_enough_for_local_leaderboard(score):
	if LOCAL_HIGHSCORES.size() < 10 or LOCAL_HIGHSCORES[-1]["score"] < score:
		return true
	else:
		return false


func add_new_local_highscore():
	if score_is_high_enough_for_local_leaderboard(SCORE):
		LOCAL_HIGHSCORES.append({"name": PLAYER_NAME, "score":SCORE})
	LOCAL_HIGHSCORES.sort_custom(Callable(self,"customPlayerComparison"))
	if LOCAL_HIGHSCORES.size() > 10:
		LOCAL_HIGHSCORES.pop_back()
	save_highscores_to_disk()


func customPlayerComparison(player_a, player_b):
	return player_a["score"] > player_b["score"]


func save_highscores_to_disk():
	var save_file = FileAccess.open("user://highscores.save", FileAccess.WRITE)
	save_file.store_var(LOCAL_HIGHSCORES, true)


func load_highscores_from_disk():
	if not FileAccess.file_exists("user://highscores.save"):
		return # Error! We don't have a save to load.
	var save_file = FileAccess.open("user://highscores.save", FileAccess.READ)
	var array = save_file.get_var(true)
	LOCAL_HIGHSCORES = array
