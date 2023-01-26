extends Node2D

var PLAYER_NAME = null
var SCORE = null

var GAME_NAME : String = "demo-vaan"
# TODO: Find a way to store this value externally
var BACK_END_URL : String = "http://localhost:8080/highscores/" # REMEMBER TO ADD "http://"

func _ready():
	assert(GAME_NAME != "")
	assert(BACK_END_URL != "")
	# TODO: Check if url is valid (need to contain http for example)
