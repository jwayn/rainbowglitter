class_name HurtboxComponent
extends Node2D

@export var health_component: HealthComponent
signal has_hurt

func _on_area_entered(hitbox: HitboxComponent):
	if hitbox == null:
		return
	
	if health_component:
		health_component.take_damage(hitbox.damage)
