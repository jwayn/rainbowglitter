extends Node2D

# TODO: Spawn path follow 2Ds _with_ enemies, then add those to 
var current_time = 0
var current_index = 0
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

func _ready():
	enemies = [
		{
			"type": 0,
			"formation": 1,
			"parent": p1,
			"spawn_time": 0.5,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p2,
			"spawn_time": 1.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p3,
			"spawn_time": 1.5,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p4,
			"spawn_time": 2.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p9,
			"spawn_time": 4.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p8,
			"spawn_time": 4.5,
			"item": {
				"chance": 1,
				"type": 0,
			}
		}
		,{
			"type": 0,
			"formation": 1,
			"parent": p7,
			"spawn_time": 5.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": p6,
			"spawn_time": 5.5,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c1,
			"spawn_time": 10.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c1,
			"spawn_time": 11.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c1,
			"spawn_time": 12.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c1,
			"spawn_time": 13.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c2,
			"spawn_time": 16.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c2,
			"spawn_time": 17.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c2,
			"spawn_time": 18.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": c2,
			"spawn_time": 19.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d1,
			"spawn_time": 28.0,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d2,
			"spawn_time": 29,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d1,
			"spawn_time": 30,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d2,
			"spawn_time": 31,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d1,
			"spawn_time": 32,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
		{
			"type": 0,
			"formation": 1,
			"parent": d2,
			"spawn_time": 33,
			"item": {
				"chance": 1,
				"type": 0,
			}
		},
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_index <= enemies.size() - 1:
		if enemies[current_index]["spawn_time"] == snapped(current_time, 0.01):
			var e = enemy_types[enemies[current_index]["type"]].instantiate()
			enemies[current_index]["parent"].add_child(e)
			current_index += 1
	current_time += delta
