extends HSlider

var master_bus_index = AudioServer.get_bus_index("Master")


func _ready():
	connect("value_changed", _on_HSlider_value_changed)
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(self.value))


func _on_HSlider_value_changed(new_value):
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(new_value))
