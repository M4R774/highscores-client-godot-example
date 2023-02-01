extends LineEdit

func _ready():
	var _result = self.connect("text_changed", self, "text_changed")
	var _result2 = self.connect("text_entered", $"../Submit", "to_highscores")


func text_changed(new_text):
	if new_text.is_valid_integer():
		$"../Submit".disabled = false
		HIGHSCORE_SINGLETON.SCORE = int(new_text)
	else:
		$"../Submit".disabled = true
		HIGHSCORE_SINGLETON.SCORE = null
