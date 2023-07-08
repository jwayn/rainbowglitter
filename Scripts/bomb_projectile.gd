extends Node2D

@export var initial_speed: float = 1
@export var max_speed: float = 1000

var direction: Vector2 = Vector2(0, -1)
var current_speed = initial_speed
var is_blowing_up = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_blowing_up:
		current_speed = lerp(current_speed, max_speed, .025)
		position += direction * delta * current_speed

func set_direction(new_dir):
	direction = new_dir

func _on_contact_collider_area_entered(area):
	is_blowing_up = true
	$bomb_sprite.visible = false
	$ContactCollider/CollisionShape2D.set_deferred("disabled", true)
	$ExplosionCollider/ExplosionCollisionShape.set_deferred("disabled", false)
	$AnimationPlayer.play("explode")
	await $AnimationPlayer.animation_finished
	queue_free()

func set_target(target):
	pass
