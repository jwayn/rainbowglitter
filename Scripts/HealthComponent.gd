class_name HealthComponent
extends Node2D

@export var MAX_HEALTH: int
@export var STARTING_HEALTH: int
@export var VISIBLE_HEALTH_BAR: bool = false
#@export var HEALTH_BAR_COMPONENT: HealthBarComponent


signal health_depleted

@onready var current_health: int = STARTING_HEALTH
var is_invincible: bool


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_health <= 0:
		die()


func take_damage(damage) -> void:
	if !is_invincible:
		current_health -= damage


func gain_health(health) -> void:
	current_health += health
	if current_health > MAX_HEALTH:
		current_health = MAX_HEALTH

func die() -> void:
	health_depleted.emit()
	
