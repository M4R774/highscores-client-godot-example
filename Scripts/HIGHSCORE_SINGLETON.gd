extends Node2D

var PLAYER_NAME = null
var SCORE = null

var GAME_NAME : String = ""
var LOCAL_HIGHSCORES : Array = []


func _ready():
	GAME_NAME = ProjectSettings.get_setting('application/config/name')
	assert(GAME_NAME != "")


func score_is_high_enough_for_local_leaderboard(score):
	if LOCAL_HIGHSCORES.size() < 10 or LOCAL_HIGHSCORES[-1].Score < score:
		return true
	else:
		return false


func add_new_local_highscore():
	if score_is_high_enough_for_local_leaderboard(SCORE):
		LOCAL_HIGHSCORES.append(PlayerScore.new(PLAYER_NAME, SCORE))
	LOCAL_HIGHSCORES.sort_custom(self, "customPlayerComparison")
	if LOCAL_HIGHSCORES.size() > 10:
		LOCAL_HIGHSCORES.pop_back()


class PlayerScore:
	var Name: String
	var Score: int

	func _init(name, score):
		self.Name = name
		self.Score = score


func customPlayerComparison(player_a, player_b):
	return player_a.Score > player_b.Score
