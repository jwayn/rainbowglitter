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


func setTarget(startPosition, targetPosition):
	if startPosition && targetPosition:
		direction = startPosition.direction_to(targetPosition).normalized()
