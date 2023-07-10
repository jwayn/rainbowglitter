extends Node2D

@export_enum("Gun", "Bomb") var type: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pickup_area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$PickupArea/CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
	$Audio.play()
	await $Audio.finished
	queue_free()
