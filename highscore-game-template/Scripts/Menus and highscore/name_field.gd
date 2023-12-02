extends LineEdit


func _ready():
	max_length = 20
	if HIGHSCORE_SINGLETON.PLAYER_NAME != null:
		self.text = HIGHSCORE_SINGLETON.PLAYER_NAME
		self.select_all()
	var _result = self.connect("text_changed",Callable(self,"text_changed"))
	var _result2 = self.connect("text_submitted",Callable(self,"enter_pressed"))


func text_changed(new_text):
	HIGHSCORE_SINGLETON.PLAYER_NAME = new_text


func enter_pressed(_new_text):
	HIGHSCORE_SINGLETON.PLAYER_NAME = self.text
	$"../Submit".submit()
