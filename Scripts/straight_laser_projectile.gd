extends Node2D

@export var speed: float = 600
var direction: Vector2 = Vector2(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * delta * speed

func set_target(target):
	pass


func _on_hitbox_component_area_entered(area):
	queue_free()
