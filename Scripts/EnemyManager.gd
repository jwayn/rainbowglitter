extends Node2D

# TODO: Spawn path follow 2Ds _with_ enemies, then add those to 
var current_time = 0
var current_index = 0
var powerup_index = 0

var powerup_scene = preload("res://Scenes/powerups/powerup_container.tscn")

@export var enemy_types: Array[PackedScene]
@onready var p1 = get_node("FlightPaths/VerticalPath1")
@onready var p2 = get_node("FlightPaths/VerticalPath2")
@onready var p3 = get_node("FlightPaths/VerticalPath3")
@onready var p4 = get_node("FlightPaths/VerticalPath4")
@onready var p5 = get_node("FlightPaths/VerticalPath5")
@onready var p6 = get_node("FlightPaths/VerticalPath6")
@onready var p7 = get_node("FlightPaths/VerticalPath7")
@onready var p8 = get_node("FlightPaths/VerticalPath8")
@onready var p9 = get_node("FlightPaths/VerticalPath9")
@onready var c1 = get_node("FlightPaths/CircularPath1")
@onready var c2 = get_node("FlightPaths/CircularPath2")
@onready var d1 = get_node("FlightPaths/DiagonalPath1")
@onready var d2 = get_node("FlightPaths/DiagonalPath2")

var enemies
var powerups

func _ready():
	
	enemies = [
		# Wave 1
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 0.5,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 1.0,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 1.5,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 4.0,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 4.5,
		}
		,{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 5.0,
		},
		# Wave 2
		{
			"type": 1,
			"parent": c1,
			"speed": 150,
			"spawn_time": 10.0,
		},
		{
			"type": 1,
			"parent": c1,
			"speed": 150,
			"spawn_time": 11.0,
		},
		{
			"type": 1,
			"parent": c1,
			"speed": 150,
			"spawn_time": 12.0,
		},
		{
			"type": 1,
			"parent": c1,
			"speed": 150,
			"spawn_time": 13.0,
		},
		{
			"type": 1,
			"parent": c2,
			"speed": 150,
			"spawn_time": 16.0,
		},
		{
			"type": 1,
			"parent": c2,
			"speed": 150,
			"spawn_time": 17.0,
		},
		{
			"type": 1,
			"parent": c2,
			"speed": 150,
			"spawn_time": 18.0,
		},
		{
			"type": 1,
			"parent": c2,
			"speed": 150,
			"spawn_time": 19.0,
		},
		# Wave 3
		{
			"type": 0,
			"parent": d1,
			"speed": 200,
			"spawn_time": 24.0,
		},
		{
			"type": 0,
			"parent": d2,
			"speed": 200,
			"spawn_time": 25,
		},
		{
			"type": 2,
			"parent": d1,
			"speed": 200,
			"spawn_time": 26,
		},
		{
			"type": 2,
			"parent": d2,
			"speed": 200,
			"spawn_time": 27,
		},
		{
			"type": 3,
			"parent": d1,
			"speed": 150,
			"spawn_time": 28,
		},
		{
			"type": 3,
			"parent": d2,
			"speed": 150,
			"spawn_time": 29,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 30,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 30,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 30.25,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 30.25,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 30.25,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 30.25,
		},
		# Wave 4
		{
			"type": 3,
			"parent": c1,
			"speed": 200,
			"spawn_time": 38,
		},
		{
			"type": 3,
			"parent": c2,
			"speed": 200,
			"spawn_time": 38,
		},
		{
			"type": 3,
			"parent": c1,
			"speed": 200,
			"spawn_time": 38.5,
		},
		{
			"type": 3,
			"parent": c2,
			"speed": 200,
			"spawn_time": 38.5,
		},
		{
			"type": 3,
			"parent": c1,
			"speed": 200,
			"spawn_time": 39,
		},
		{
			"type": 3,
			"parent": c2,
			"speed": 200,
			"spawn_time": 39,
		},
		{
			"type": 3,
			"parent": c1,
			"speed": 200,
			"spawn_time": 39.5,
		},
		{
			"type": 3,
			"parent": c2,
			"speed": 200,
			"spawn_time": 39.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 40,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 40,
		},
		# Wave 5
		{
			"type": 3,
			"parent": p5,
			"speed": 150,
			"spawn_time": 50,
		},
		{
			"type": 3,
			"parent": p4,
			"speed": 150,
			"spawn_time": 46,
		},
		{
			"type": 3,
			"parent": p6,
			"speed": 150,
			"spawn_time": 46,
		},
		{
			"type": 3,
			"parent": p2,
			"speed": 150,
			"spawn_time": 47,
		},
		{
			"type": 3,
			"parent": p1,
			"speed": 150,
			"spawn_time": 48,
		},
		{
			"type": 3,
			"parent": p3,
			"speed": 150,
			"spawn_time": 48,
		},
		{
			"type": 3,
			"parent": p8,
			"speed": 150,
			"spawn_time": 49,
		},
		{
			"type": 3,
			"parent": p7,
			"speed": 150,
			"spawn_time": 50,
		},
		{
			"type": 3,
			"parent": p9,
			"speed": 150,
			"spawn_time": 50,
		},
	]
	
	powerups = [
		{
			"type": 0,
			"spawn_time": 5
		},
		{
			"type": 1,
			"spawn_time": 10
		},
		{
			"type": 1,
			"spawn_time": 21
		},
		{
			"type": 0,
			"spawn_time": 33
		},
		{
			"type": 1,
			"spawn_time": 36
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_index <= enemies.size() - 1:
		if enemies[current_index]["spawn_time"] <= snapped(current_time, 0.01):
			var e = enemy_types[enemies[current_index]["type"]].instantiate()
			e.speed = enemies[current_index]["speed"]
			enemies[current_index]["parent"].add_child(e)
			current_index += 1
	else:
		spawn_boss()
		
	if powerup_index <= powerups.size() - 1:
		if powerups[powerup_index]["spawn_time"] <= snapped(current_time, 0.01):
			var powerup = powerup_scene.instantiate()
			powerup.change_type(powerups[powerup_index]["type"])
			$/root/World/Bullets.add_child(powerup)
			powerup_index += 1
	current_time += delta

func spawn_boss():
	pass
