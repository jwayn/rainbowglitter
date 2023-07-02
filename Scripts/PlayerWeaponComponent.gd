class_name PlayerWeaponComponent
extends Node2D

@export var time_between_shots: float = 1
@export var projectile: PackedScene
@export var projectile_origin: Marker2D
@export var bullets_container: Node2D
@export var button_action: String = "ui_accept"

var can_fire = true

func _process(delta):
	handle_shooting_input()

func handle_shooting_input():
	if Input.is_action_pressed(button_action):
		if can_fire:
			_fire_weapon()

func _fire_weapon():
	if projectile:
		var p = projectile.instantiate()
		$/root/World/Bullets.add_child(p)
		p.position = projectile_origin.global_position
		can_fire = false
		$FireTimer.start(time_between_shots)
		$AudioPlayer.play()
	

func _on_fire_timer_timeout():
	can_fire = true
