extends Node2D

@export var SPEED = 250
var direction
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction:
		position += direction * SPEED * delta
	
	if !is_on_screen():
		queue_free()

func setTarget(startPosition, targetPosition):
	if startPosition && targetPosition:
		direction = startPosition.direction_to(targetPosition).normalized()

func is_on_screen() -> bool:
	if global_position.y < 0 || global_position.y > 1080 || global_position.x < 576 || global_position.x > 1344:
		return false
	else:
		return true
