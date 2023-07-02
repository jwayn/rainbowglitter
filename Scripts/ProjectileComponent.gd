class_name ProjectileComponent
extends Node2D

@export_enum("Straight Ahead", "Lock-On", "Initial Target") var targeting_type: int
@export var speed: int = 200
@export var max_number_of_collisions = 1

var collisions = 0
var direction: Vector2
var target_position: Vector2 = Vector2.ZERO

func _ready():
	if targeting_type == 2 && target_position != Vector2.ZERO:
		set_direction(position, target_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Straight Ahead
	if targeting_type == 0:
		position += -transform.y * delta * speed
	# Lock-On
	if targeting_type == 1:
		set_direction(position, target_position)
		
	if direction:
		position += direction * speed * delta

func set_direction(start_position, target_position):
	if start_position && target_position:
		direction = start_position.direction_to(target_position).normalized()


func _on_hitbox_component_area_entered(area):
	if area.get_collision_layer_value(3):
		collisions += 1
		if collisions >= max_number_of_collisions:
			queue_free()
