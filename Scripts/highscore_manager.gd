extends Control

export var playername_prompt_path := @""; onready var playername_prompt := get_node(playername_prompt_path) as Node
export var namefield_path := @""; onready var namefield := get_node(namefield_path) as Node
export var loading_icon_path := @""; onready var loading_icon := get_node(loading_icon_path) as Node2D
export var to_main_menu_path := @""; onready var to_main_menu := get_node(to_main_menu_path) as Node
export var local_highscores_text_path := @""; onready var local_highscores_text := get_node(local_highscores_text_path) as RichTextLabel
export var online_highscores_text_path := @""; onready var online_highscores_text := get_node(online_highscores_text_path) as RichTextLabel

var http_client = HTTPClient.new()
var back_end_url = ""


func _ready():
	back_end_url = "https://" + SECRETS.DOMAIN + "/highscores/" + HIGHSCORE_SINGLETON.GAME_NAME
	playername_prompt.visible = false
	to_main_menu.grab_focus()
	update_highscores_table()
	check_if_players_score_is_high_enough()


func update_highscores_table():
	update_local_highscores_table()

	loading_icon.visible = true
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_on_get_highscores_request_completed")
	request.request(back_end_url)


func update_local_highscores_table():
	var local_highscores_text_content = ""
	for player in HIGHSCORE_SINGLETON.LOCAL_HIGHSCORES:
		local_highscores_text_content += ("%-21s" % player.Name + str(player.Score) + "\n")
	local_highscores_text.text = local_highscores_text_content


func _on_get_highscores_request_completed(_result, _response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	online_highscores_text.text = response_body
	loading_icon.visible = false


func check_if_players_score_is_high_enough():
	if HIGHSCORE_SINGLETON.SCORE == null:
		return

	# Offline
	if HIGHSCORE_SINGLETON.score_is_high_enough_for_local_leaderboard(HIGHSCORE_SINGLETON.SCORE):
		ask_for_players_name()
	else:
		# Online
		var request = HTTPRequest.new()
		add_child(request)
		request.connect("request_completed", self, "_on_check_if_high_enough_request_completed")
		request.request(back_end_url + "?score=" + str(HIGHSCORE_SINGLETON.SCORE))


func _on_check_if_high_enough_request_completed(_result, _response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	if response_body == "true":
		ask_for_players_name()
	else:
		print("Score is not high enough...")


func ask_for_players_name():
	playername_prompt.visible = true
	namefield.grab_focus()


func post_highscores_online():
	HIGHSCORE_SINGLETON.add_new_local_highscore()
	update_local_highscores_table()
	loading_icon.visible = true
	var payload_dict = {"name":HIGHSCORE_SINGLETON.PLAYER_NAME, "score":HIGHSCORE_SINGLETON.SCORE}
	var payload_string = http_client.query_string_from_dict(payload_dict)
	var auth=str("Basic ",
			Marshalls.utf8_to_base64(
				str(SECRETS.USERNAME, ":", SECRETS.PASSWORD)))
	var headers = ["Content-Type: application/x-www-form-urlencoded",
				   "Content-Length: " + str(payload_string.length()),
				   "Authorization: "+auth]
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_on_post_highscores_request_completed")
	request.request(back_end_url, headers, false, HTTPClient.METHOD_POST, payload_string)
	HIGHSCORE_SINGLETON.SCORE = null
	to_main_menu.grab_focus()


func _on_post_highscores_request_completed(_result, _response_code, _headers, _body):
	update_highscores_table()
