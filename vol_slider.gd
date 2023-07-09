extends HSlider


var bus
func _ready():
	bus = AudioServer.get_bus_index("Master")
	value = db_to_linear(AudioServer.get_bus_volume_db(bus))
	update_label(value)

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	update_label(value)

func update_label(value):
	get_parent().get_node("vol_label").text = str(roundi(value * 100))	
