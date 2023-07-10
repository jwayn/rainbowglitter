extends Node2D

var speed = 150
@export var markers: Array[Marker2D]
var current_target_position: Vector2
var at_target_position = false
var initial_spawn = true
# Called when the node enters the scene tree for the first time.
func _ready():
	current_target_position = markers[0].position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_towards_target_position(delta)

func move_towards_target_position(delta):
	var direction = position.direction_to(current_target_position)
	position += speed * delta * direction
	
	if initial_spawn:
		$/root/World/Camera.apply_noise_shake_override(15)
	
	if position.distance_to(current_target_position) <= 2:
		initial_spawn = false
		at_target_position = true
		current_target_position = pick_random_target_position()

func pick_random_target_position():
	return markers[randi() % markers.size()].position


func _lg1_on_health_component_health_depleted():
	pass # Replace with function body.
