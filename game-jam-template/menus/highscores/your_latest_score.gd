extends Label


func _ready():
	if HIGHSCORE_SINGLETON.SCORE != null:
		self.text = "Your latest score: " + str(HIGHSCORE_SINGLETON.SCORE)
	else:
		self.text = ""
