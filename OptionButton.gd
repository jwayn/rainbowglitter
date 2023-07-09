extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	var window_mode = DisplayServer.window_get_mode()
	if window_mode == 0:
		selected = 1
	else:
		selected = 0

