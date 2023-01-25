extends HTTPRequest

var http = HTTPClient.new()
export var GAME_NAME : String
export var BACK_END_URL : String

func _ready():
	assert(GAME_NAME != "")
	assert(BACK_END_URL != "")
	self.connect("request_completed", self, "_on_request_completed")
	get_highscores_online()

func get_highscores_online():
	$".".request(BACK_END_URL + GAME_NAME)

func post_highscores_online(username, score):
	var url = BACK_END_URL + GAME_NAME
	var payload_dict = {"name":username, "score":score}
	var payload_string = http.query_string_from_dict(payload_dict)
	var headers = ["Content-Type: application/x-www-form-urlencoded", 
				   "Content-Length: " + str(payload_string.length())]
	$HTTPRequest.request(url, headers, false, HTTPClient.METHOD_POST, payload_string)

func _on_request_completed(result, response_code, headers, body):
	var response_body = body.get_string_from_utf8()
	print(response_body)
	$"../Scores".text = response_body
