class_name HurtboxComponent
extends Node2D

@export var health_component: HealthComponent
signal on_hit

func _on_area_entered(area):
	if area == null:
		return
	
	on_hit.emit()
	if health_component:
		health_component.take_damage(area.damage)
