extends LineEdit


func _ready():
	max_length = 20
	if HIGHSCORE_SINGLETON.PLAYER_NAME != null:
		$".".text = HIGHSCORE_SINGLETON.PLAYER_NAME
	var _result = self.connect("text_changed", self, "text_changed")
	var _result2 = self.connect("text_entered", self, "enter_pressed")

func text_changed(new_text):
	HIGHSCORE_SINGLETON.PLAYER_NAME = new_text

func enter_pressed(_new_text):
	$"../Submit"._pressed()
