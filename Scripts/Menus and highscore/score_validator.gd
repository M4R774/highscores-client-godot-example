extends LineEdit


func _ready():
	self.grab_focus()
	var _result = self.connect("text_changed",Callable(self,"text_changed"))
	var _result2 = self.connect("text_submitted",Callable(self,"enter_pressed"))


func _process(_delta):  # Experimental mobile keyboard does not emit text_changed signal
	text_changed(self.text)


func text_changed(new_text):
	if new_text.is_valid_int():
		$"../Submit".disabled = false
		HIGHSCORE_SINGLETON.SCORE = int(new_text)
	else:
		$"../Submit".disabled = true
		HIGHSCORE_SINGLETON.SCORE = null


func enter_pressed(_new_text):
	if not $"../Submit".disabled:
		$"../Submit"._pressed()
