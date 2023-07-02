class_name EnemyWeaponComponent
extends Node2D

@export var origin: Marker2D
@export var audio_player: RandomAudioPlayerComponent
@export var projectile: PackedScene
@export var minimum_range: float
@export var time_between_shots: float = 10

var target: CharacterBody2D
var is_charging: bool = false
var can_shoot: bool = true

func _process(delta):
	if target && can_shoot:
		fire_weapon()

func fire_weapon():
	can_shoot = false
	instantiate_projectile()
	$WeaponSpeedTimer.start(time_between_shots)

func _on_range_collider_area_entered(area):
	if area.get_collision_layer_value(4):
		target = area.get_parent()

func _on_weapon_speed_timer_timeout():
	can_shoot = true

func play_charge_animation():
	pass

func instantiate_projectile():
	var p = projectile.instantiate()
	origin.add_child(p)
	p.set_target(target)
