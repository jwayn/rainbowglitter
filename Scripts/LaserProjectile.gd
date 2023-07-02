extends Node2D

@export var charge_time: float = 1
@export var laser_persistance = .25

var is_telegraphing: bool = true
var target: CharacterBody2D
var direction: Vector2
var final_target_position: Vector2
var has_telegraphed: bool = false
var telegraph_has_cleared: bool = false
var laser_has_fired: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_telegraphing && is_instance_valid(target):
		if !has_telegraphed:
			has_telegraphed = true
			$TelegraphTimer.start(charge_time)
		# If either telegraph or lasers are fading, they should be following 
		# the final target position rather than the player
		elif $AnimationPlayer.is_playing():
			draw_telegraph_line(to_local(final_target_position))
		# If no animations are playing but the timer has started,
		# just follow the target's current position
		else:
			draw_telegraph_line(to_local(target.global_position))

	else:
		draw_laser()
	
func draw_telegraph_line(target_pos):
	$Telegraph.clear_points()
	if is_instance_valid(target):
		$Telegraph.add_point(self.position)
		var pos = get_direction(self.position, target_pos)
		$Telegraph.add_point(pos + (pos * -1920))

func set_target(new_target):
	target = new_target

func get_direction(from, to):
	return (from - to).normalized()

func _on_charge_timer_timeout():
	if(is_instance_valid(target)):
		final_target_position = Vector2(target.global_position)
	$AnimationPlayer.play("FadeTelegraphOut")
	
func clear_telegraph():
	if !telegraph_has_cleared:
		telegraph_has_cleared = true
		is_telegraphing = false
		$Telegraph.clear_points()
		$LaserPersistence.start(laser_persistance)
		$Laser/HitboxComponent/CollisionShape2D.disabled = false
	
	
	
func draw_laser():
	$Laser.clear_points()
	$Laser.add_point(self.position)
	var pos = get_direction(self.position, to_local(final_target_position))
	$Laser.add_point(pos + (pos * -1920))
	if !laser_has_fired:
		create_hitbox()
	

func _on_laser_persistence_timeout():
	laser_has_fired = true
	$Laser/HitboxComponent/CollisionShape2D.disabled = true
	$AnimationPlayer.play("FadeLaserOut")

func create_hitbox():
	for i in $Laser.points.size() - 1:
		var shape = $Laser/HitboxComponent/CollisionShape2D.get_shape()
		$Laser/HitboxComponent/CollisionShape2D.position = Vector2(($Laser.points[i] + $Laser.points[i + 1]) / 2)
		$Laser/HitboxComponent/CollisionShape2D.rotation = $Laser.points[i].direction_to($Laser.points[i + 1]).angle()
		var length = $Laser.points[i].distance_to($Laser.points[i + 1])
		shape.extents = Vector2(length / 2, 10)

func remove_laser():
	queue_free()
