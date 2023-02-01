extends Button


func _pressed():
	$"../../../../..".visible = false
	$"../../../../../../Scoreboard/VBoxContainer/MarginContainer/Scores".post_highscores_online()
