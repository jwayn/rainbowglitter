extends Node2D

var menu_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	menu_scene = load("res://menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("game_menu"):
		get_tree().paused = true
		$pause_screen.show()


func _on_option_button_item_selected(index):
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_save_pressed():
	get_tree().paused = false
	$pause_screen.hide()


func _on_quit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu_scene)


func _on_quit_to_desktop_pressed():
	get_tree().quit()

