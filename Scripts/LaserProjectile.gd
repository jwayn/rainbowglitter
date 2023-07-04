extends Node2D

@export var telegraph_time: float = 1
@export var laser_persistance = .25

var telegraph_timer_started: bool = false
var has_telegraphed: bool = false
var has_final_target: bool = false
var has_force_pull_completed: bool = false
var target: CharacterBody2D
var direction: Vector2
var final_target_position: Vector2
var laser_has_fired: bool = false

func _ready():
	print("Target acquired. laser instantiated.")

func _process(delta):
	if !telegraph_timer_started && !has_telegraphed && is_instance_valid(target):
		telegraph_timer_started = true
		# calls _on_charge_timer_timeout()
		print("Starting the telegraph timer.")
		$TelegraphTimer.start(telegraph_time)

	if !has_telegraphed && !has_final_target:
		print("We should be drawing the telegraph line to the player's position")
		draw_telegraph_line(to_local(target.global_position))

	elif !has_telegraphed && has_final_target:
		print("We should be drawing the telegraph line to the final position")
		draw_telegraph_line(to_local(final_target_position))

	elif has_telegraphed && has_force_pull_completed:
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
	print("Telegraph time over, fading out")
	if(is_instance_valid(target)):
		has_final_target = true
		final_target_position = Vector2(target.global_position)
	# Animation calls clear_telegraph()
	$AnimationPlayer.play("FadeTelegraphOut")

func clear_telegraph():
	print("Fade out animation over, playing force pull")
	$Telegraph.clear_points()
	has_telegraphed = true
	# Animation calls fire_laser()
	$AnimationPlayer.play("force_pull")

# draws the actual laser line
func draw_laser():
	$Laser.clear_points()
	$Laser.add_point(self.position)
	var pos = get_direction(self.position, to_local(final_target_position))
	$Laser.add_point(pos + (pos * -1920))
	if !laser_has_fired:
		create_hitbox()

func fire_laser():
	has_force_pull_completed = true
	print("Force pull done, firing laser")
	# Timer calls _on_laser_persistence_timeout()
	$LaserPersistence.start(laser_persistance)
	$Laser/HitboxComponent/CollisionShape2D.disabled = false

func _on_laser_persistence_timeout():
	print("Laser done, fading it out")
	laser_has_fired = true
	$Laser/HitboxComponent/CollisionShape2D.disabled = true
	$AnimationPlayer.play("FadeLaserOut")

# Creates the laser hitbox and positions it correctly
func create_hitbox():
	for i in $Laser.points.size() - 1:
		var shape = $Laser/HitboxComponent/CollisionShape2D.get_shape()
		$Laser/HitboxComponent/CollisionShape2D.position = Vector2(($Laser.points[i] + $Laser.points[i + 1]) / 2)
		$Laser/HitboxComponent/CollisionShape2D.rotation = $Laser.points[i].direction_to($Laser.points[i + 1]).angle()
		var length = $Laser.points[i].distance_to($Laser.points[i + 1])
		shape.extents = Vector2(length / 2, 10)

func remove_laser():
	print("Laser fade out done, destroying")
	queue_free()
