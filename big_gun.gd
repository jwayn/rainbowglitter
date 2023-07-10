extends Node2D

@export var projectile_scene: PackedScene
@export var time_between_shots: float = .5

signal gun_died
var can_shoot: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_shoot:
		fire_weapon($/root/World/Player)


func look_at_target(target):
	if is_instance_valid(target):
		look_at(to_global(target.position))
		to_global

func fire_weapon(target):
	var projectile = projectile_scene.instantiate()
	$/root/World/Bullets.add_child(projectile)
	projectile.position = to_global($spawn.position)
	projectile.set_target(target)
	can_shoot = false
	$shot_timer.start(time_between_shots)


func _on_shot_timer_timeout():
	can_shoot = true


func _on_health_component_health_depleted():
	print("We're out of health")
	explode_then_die()

func explode_then_die():
	$GunSprite.hide()
	$/root/World/Camera.apply_noise_shake_override(80)
	$AnimationPlayer.play("Die")

func die():
	gun_died.emit()
	queue_free()


func _on_health_component_damage_taken():
	$AnimationPlayer.play("hit")
	$HitSound.play()
