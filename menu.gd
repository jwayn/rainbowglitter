extends Control

var sparkle_markers
var world_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	world_scene = load("res://World.tscn")
	sparkle_markers = $sparkle_markers.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_packed(world_scene)
	play_click_sound()


func _on_quit_pressed():
	get_tree().quit()
	play_click_sound()
	


func _on_options_pressed():
	play_click_sound()

func start_sparkle_timer():
	randomize()
	var sparkle_time = randf_range(.25, 4)
	print(sparkle_time)
	$sparkle_timer.start(sparkle_time)

func move_sparkle_to_random_location_and_play():
	var marker = sparkle_markers[randi() % sparkle_markers.size()]
	$sparkle.position = marker.position
	$MSGSparkles.play()


func _on_sparkle_timer_timeout():
	move_sparkle_to_random_location_and_play()

func play_click_sound():
	$ClickSound.play()

func play_hover_sound():
	$HoverSound.play()

func _on_play_mouse_entered():
	play_hover_sound()


func _on_quit_mouse_entered():
	play_hover_sound()


func _on_options_mouse_entered():
	play_hover_sound()
