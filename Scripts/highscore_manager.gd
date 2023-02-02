extends RichTextLabel

var http_client = HTTPClient.new()
var back_end_url = ""

func _ready():
	back_end_url = "https://" + HIGHSCORE_SINGLETON.BACKEND_DOMAIN + "/highscores/" + HIGHSCORE_SINGLETON.GAME_NAME
	$"../../../../Playername_prompt".visible = false
	update_highscores_table()
	check_if_players_score_is_high_enough()


func update_highscores_table():
	$"../Loading-icon".visible = true
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_on_get_highscores_request_completed")
	request.request(back_end_url)
	#request.queue_free()


func _on_get_highscores_request_completed(_result, _response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	self.text = response_body
	$"../Loading-icon".visible = false


func check_if_players_score_is_high_enough():
	if HIGHSCORE_SINGLETON.SCORE == null:
		return
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_on_check_if_high_enough_request_completed")
	request.request(back_end_url + "?score=" + str(HIGHSCORE_SINGLETON.SCORE))
	#request.queue_free()


func _on_check_if_high_enough_request_completed(_result, _response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	if response_body == "true":
		$"../../../../Playername_prompt".visible = true
		$"../../../../Playername_prompt/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/NameField".grab_focus()
	else:
		print("Score is not high enough...")


func post_highscores_online():
	$"../Loading-icon".visible = true
	var payload_dict = {"name":HIGHSCORE_SINGLETON.PLAYER_NAME, "score":HIGHSCORE_SINGLETON.SCORE}
	var payload_string = http_client.query_string_from_dict(payload_dict)
	var auth=str("Basic ", 
			Marshalls.utf8_to_base64(
				str(HIGHSCORE_SINGLETON.BACKEND_USERNAME, ":", HIGHSCORE_SINGLETON.BACKEND_PASSWORD))) 
	var headers=["Content-Type: application/json","Authorization: "+auth]
	var headers = ["Content-Type: application/x-www-form-urlencoded",
				   "Content-Length: " + str(payload_string.length()),
				   "Authorization: "+auth]
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", self, "_on_post_highscores_request_completed")
	request.request(back_end_url, headers, false, HTTPClient.METHOD_POST, payload_string)
	HIGHSCORE_SINGLETON.SCORE = null
	#request.queue_free()


func _on_post_highscores_request_completed(_result, _response_code, _headers, _body):
	update_highscores_table()
