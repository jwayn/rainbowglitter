extends CharacterBody2D

const MAX_GUNS = 4

@export var move_speed = 150.0
@export var max_bombs: int  = 3
@export_range(0, MAX_GUNS) var num_active_guns = 1

@onready var left_gun_1 = $"Left Gatling Gun"
@onready var right_gun_1 = $"Right Gatling Gun"
@onready var left_gun_2 = $"Left Gatling Gun2"
@onready var right_gun_2 = $"Right Gatling Gun2"
@onready var guns = [left_gun_1, right_gun_1, left_gun_2, right_gun_2,]

var game_over_screen
var is_moving = false
var flame_trail
var is_dead: bool = false


func _ready():
	flame_trail = $Ship/AnimatedSprite2D
	game_over_screen = load("res://game_over.tscn")
	

func handle_movement(delta):
	# Creates a variable to store our movement direction in
	var direction = Vector2(0, 0)
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT

	# We are moving if our direction vector isn't 0,0
	if direction != Vector2(0,0):
		is_moving = true
	else:
		is_moving = false
	
	move_and_collide(direction.normalized() * move_speed * delta)
	
	if is_moving:
		flame_trail.scale.y = 1
		flame_trail.position.y = 24
	else:
		flame_trail.scale.y = .25
		flame_trail.position.y = 18.709

func _physics_process(delta):
	if !is_dead:
		handle_movement(delta)


func _on_health_component_health_depleted():
	is_dead = true
	$Ship.visible = false
	$explosion.visible = true
	$AnimationPlayer.play('die')
	

func die():
	queue_free()
	get_tree().change_scene_to_packed(game_over_screen)


func _on_health_component_damage_taken():
	$AnimationPlayer.play('hit')
	$HitmarkerAudio.play()


func _on_powerup_picker_upper_area_entered(area):
	var pickup_type = area.get_parent().type
	match(pickup_type):
		0:
			activate_next_gun()
		1:
			pickup_bomb()

func pickup_bomb():
	if $"Bomb Gun".ammo < max_bombs:
		$"Bomb Gun".set_ammo($"Bomb Gun".ammo + 1)

func activate_next_gun():
	if num_active_guns < MAX_GUNS:
		num_active_guns += 1
		guns[num_active_guns - 1].active = true
