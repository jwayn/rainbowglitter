extends Control

var world_scene
var menu_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	world_scene = load("res://World.tscn")
	menu_scene = load("res://menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_packed(world_scene)


func _on_menu_pressed():
	get_tree().change_scene_to_packed(menu_scene)
