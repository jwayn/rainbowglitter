extends Node2D
@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += -transform.y * delta * speed
	if !is_on_screen():
		queue_free()

func is_on_screen() -> bool:
	if global_position.y < 0 || global_position.y > 1080 || global_position.x < 576 || global_position.x > 1344:
		return false
	else:
		return true
