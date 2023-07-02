class_name HealthComponent
extends Node2D

@export var MAX_HEALTH: int
@export var STARTING_HEALTH: int
@export var VISIBLE_HEALTH_BAR: bool = false
#@export var HEALTH_BAR_COMPONENT: HealthBarComponent

var has_sent_die_signal: bool = false

signal health_depleted
signal damage_taken

@onready var current_health: int = STARTING_HEALTH
var is_invincible: bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_health <= 0 && !has_sent_die_signal:
		die()


func take_damage(damage) -> void:
	if !is_invincible && current_health > 0:
		current_health -= damage
		if damage > 0:
			damage_taken.emit()


func gain_health(health) -> void:
	current_health += health
	if current_health > MAX_HEALTH:
		current_health = MAX_HEALTH

func die() -> void:
	has_sent_die_signal = true
	health_depleted.emit()
	
