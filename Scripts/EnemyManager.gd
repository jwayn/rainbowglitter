extends Node2D

# TODO: Spawn path follow 2Ds _with_ enemies, then add those to 
var current_time = 0
var current_index = 0
var powerup_index = 0

var powerup_scene = preload("res://Scenes/powerups/powerup_container.tscn")
var boss_scene = preload("res://Scenes/Enemies/boss/boss.tscn")

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

var has_boss_spawned = false

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
			"spawn_time": 44,
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
			"spawn_time": 47,
		},
		{
			"type": 3,
			"parent": p2,
			"speed": 150,
			"spawn_time": 48,
		},
		{
			"type": 3,
			"parent": p1,
			"speed": 150,
			"spawn_time": 49,
		},
		{
			"type": 3,
			"parent": p3,
			"speed": 150,
			"spawn_time": 49,
		},
		{
			"type": 3,
			"parent": p8,
			"speed": 150,
			"spawn_time": 50,
		},
		{
			"type": 3,
			"parent": p7,
			"speed": 150,
			"spawn_time": 51,
		},
		{
			"type": 3,
			"parent": p9,
			"speed": 150,
			"spawn_time": 52,
		},
		# wave 6
		{
			"type": 0,
			"parent": p1,
			"speed": 150,
			"spawn_time": 56
		},
		{
			"type": 0,
			"parent": p5,
			"speed": 150,
			"spawn_time": 56.2,
		},
		{
			"type": 0,
			"parent": p9,
			"speed": 150,
			"spawn_time": 56.4,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 150,
			"spawn_time": 56.6,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 150,
			"spawn_time": 57,
		},
		{
			"type": 2,
			"parent": d1,
			"speed": 150,
			"spawn_time": 57,
		},
		{
			"type": 2,
			"parent": d2,
			"speed": 150,
			"spawn_time": 57.2,
		},
		{
			"type": 2,
			"parent": d1,
			"speed": 150,
			"spawn_time": 57.4,
		},
		{
			"type": 2,
			"parent": d2,
			"speed": 150,
			"spawn_time": 57.6,
		},
		{
			"type": 2,
			"parent": d1,
			"speed": 150,
			"spawn_time": 59.5,
		},
		{
			"type": 2,
			"parent": d2,
			"speed": 150,
			"spawn_time": 59.5,
		},
		# wave 7
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 65,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 65.25,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 65.5,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 65.75,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 66,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 66.25,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 66.5,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 66.75,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 67,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 67.25,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 67.50,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 67.75,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 68,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 68.25,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 68.50,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 68.75,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 69,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 69.25,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 69.50,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 69.75,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 70,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 70.25,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 70.50,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 70.75,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 71,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 71.25,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 71.50,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 71.75,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 72,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 72.25,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 72.50,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 72.75,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 73,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 73.25,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 73.50,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 73.75,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 74,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 74.25,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 74.50,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 74.75,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 75,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 75.25,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 75.50,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 75.75,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 76,
		},
		{
			"type": 1,
			"parent": p1,
			"speed": 150,
			"spawn_time": 76.25,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 150,
			"spawn_time": 76.50,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 150,
			"spawn_time": 76.75,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 150,
			"spawn_time": 77,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 150,
			"spawn_time": 77.25,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 150,
			"spawn_time": 77.50,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 150,
			"spawn_time": 77.75,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 150,
			"spawn_time": 78,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 150,
			"spawn_time": 78.25,
		},
		# wave 8
		{
			"type": 0,
			"parent": p1,
			"speed": 150,
			"spawn_time": 84,
		},
		{
			"type": 3,
			"parent": p7,
			"speed": 200,
			"spawn_time": 84,
		},
		{
			"type": 3,
			"parent": p9,
			"speed": 200,
			"spawn_time": 84,
		},
		{
			"type": 0,
			"parent": p2,
			"speed": 160,
			"spawn_time": 84.2,
		},
		{
			"type": 0,
			"parent": p3,
			"speed": 170,
			"spawn_time": 84.4,
		},
		{
			"type": 3,
			"parent": p8,
			"speed": 200,
			"spawn_time": 84.5
		},
		{
			"type": 0,
			"parent": p4,
			"speed": 180,
			"spawn_time": 84.6,
		},
		{
			"type": 0,
			"parent": p5,
			"speed": 190,
			"spawn_time": 84.8,
		},
		{
			"type": 0,
			"parent": p6,
			"speed": 200,
			"spawn_time": 85,
		},
		# wave 9
		{
			"type": 1,
			"parent": p1,
			"speed": 200,
			"spawn_time": 90,
		},
		{
			"type": 1,
			"parent": p3,
			"speed": 200,
			"spawn_time": 90,
		},
		{
			"type": 1,
			"parent": p5,
			"speed": 200,
			"spawn_time": 90,
		},
		{
			"type": 1,
			"parent": p7,
			"speed": 200,
			"spawn_time": 90,
		},
		{
			"type": 1,
			"parent": p9,
			"speed": 200,
			"spawn_time": 90,
		},
		{
			"type": 1,
			"parent": p2,
			"speed": 200,
			"spawn_time": 90.3,
		},
		{
			"type": 1,
			"parent": p4,
			"speed": 200,
			"spawn_time": 90.3,
		},
		{
			"type": 1,
			"parent": p6,
			"speed": 200,
			"spawn_time": 90.3,
		},
		{
			"type": 1,
			"parent": p8,
			"speed": 200,
			"spawn_time": 90.3,
		},
		{
			"type": 0,
			"parent": p1,
			"speed": 200,
			"spawn_time": 91,
		},
		{
			"type": 0,
			"parent": p3,
			"speed": 200,
			"spawn_time": 91,
		},
		{
			"type": 0,
			"parent": p5,
			"speed": 200,
			"spawn_time": 91,
		},
		{
			"type": 0,
			"parent": p7,
			"speed": 200,
			"spawn_time": 91,
		},
		{
			"type": 0,
			"parent": p9,
			"speed": 200,
			"spawn_time": 91,
		},
		{
			"type": 3,
			"parent": p2,
			"speed": 200,
			"spawn_time": 91.5,
		},
		{
			"type": 3,
			"parent": p4,
			"speed": 200,
			"spawn_time": 91.5,
		},
		{
			"type": 3,
			"parent": p6,
			"speed": 200,
			"spawn_time": 91.5,
		},
		{
			"type": 3,
			"parent": p8,
			"speed": 200,
			"spawn_time": 91.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 93,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 93,
		},
		{
			"type": 3,
			"parent": p5,
			"speed": 150,
			"spawn_time": 93.2
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 93.5,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 93.5,
		},
		{
			"type": 3,
			"parent": p5,
			"speed": 150,
			"spawn_time": 93.8,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 94,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 94,
		},
		{
			"type": 3,
			"parent": p5,
			"speed": 150,
			"spawn_time": 94.3,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 94.5,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 94.5,
		},
		{
			"type": 3,
			"parent": p1,
			"speed": 150,
			"spawn_time": 94.5,
		},
		{
			"type": 3,
			"parent": p9,
			"speed": 150,
			"spawn_time": 94.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 95,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 95,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 95.5,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 95.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 96,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 96.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 97,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 97.5,
		},
		{
			"type": 2,
			"parent": c1,
			"speed": 200,
			"spawn_time": 98,
		},
		{
			"type": 2,
			"parent": c2,
			"speed": 200,
			"spawn_time": 98.5,
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
		{
			"type": 1,
			"spawn_time": 52
		},
		{
			"type": 0,
			"spawn_time": 60
		},
		{
			"type": 1,
			"spawn_time": 79
		},
		{
			"type": 0,
			"spawn_time": 105
		},
		{
			"type": 1,
			"spawn_time": 105
		},
		{
			"type": 1,
			"spawn_time": 105
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
		if !has_boss_spawned:
			has_boss_spawned = true
			$BossTimer.start(10)
		
	if powerup_index <= powerups.size() - 1:
		if powerups[powerup_index]["spawn_time"] <= snapped(current_time, 0.01):
			var powerup = powerup_scene.instantiate()
			powerup.change_type(powerups[powerup_index]["type"])
			$/root/World/Bullets.add_child(powerup)
			powerup_index += 1
	current_time += delta

func spawn_boss():
	$/root/World/MusicPlayer.stop()
	$/root/World/BossMusic.play()
	var b = boss_scene.instantiate()
	$/root/World/BossManager.add_child(b)
	b.position = Vector2(962, -252)


func _on_boss_timer_timeout():
	spawn_boss()
