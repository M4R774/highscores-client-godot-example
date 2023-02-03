extends Node2D

var PLAYER_NAME = null
var SCORE = null

var GAME_NAME : String = ""
var BACKEND_DOMAIN : String = ""  # "example.com"
var BACKEND_USERNAME : String = ""
var BACKEND_PASSWORD : String = ""

var LOCAL_HIGHSCORES : Array = []

func _ready():
	GAME_NAME = ProjectSettings.get_setting('application/config/name')
	set_values_from_config_file()
	assert(GAME_NAME != "")
	assert(BACKEND_DOMAIN != "")
	assert(BACKEND_USERNAME != "")
	assert(BACKEND_PASSWORD != "")


func set_values_from_config_file():
	var file = File.new()
	if not file.file_exists("res://config.json"):
		print("No config.json file found...")
	file.open("res://config.json", File.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = parse_json(content_as_text)
	BACKEND_DOMAIN = content_as_dictionary["domain"]
	BACKEND_USERNAME = content_as_dictionary["username"]
	BACKEND_PASSWORD = content_as_dictionary["password"]


func score_is_high_enough_for_local_leaderboard(score):
	if LOCAL_HIGHSCORES.size() < 10 or LOCAL_HIGHSCORES[-1].Score < score:
		return true
	else:
		return false


func add_new_local_highscore():
	if score_is_high_enough_for_local_leaderboard(SCORE):
		LOCAL_HIGHSCORES.append(PlayerScore.new(PLAYER_NAME, SCORE))
	LOCAL_HIGHSCORES.sort_custom(self, "customPlayerComparison")


class PlayerScore:
	var Name: String
	var Score: int

	func _init(name, score):
		self.Name = name
		self.Score = score
		

func customPlayerComparison(player_a, player_b):
	return player_a.Score < player_b.Score
