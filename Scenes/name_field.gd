extends LineEdit


func _ready():
	if HIGHSCORE_SINGLETON.PLAYER_NAME != null:
		$".".text = HIGHSCORE_SINGLETON.PLAYER_NAME
	var _result = self.connect("text_changed", self, "text_changed")

func text_changed(new_text):
	HIGHSCORE_SINGLETON.PLAYER_NAME = new_text
