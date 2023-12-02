extends PanelContainer


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		self.visible = not self.visible
		get_tree().paused = self.visible


func _on_continue_pressed():
	self.visible = false
	get_tree().paused = self.visible
