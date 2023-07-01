extends CharacterBody2D


@export var move_speed = 150.0
var is_moving = false
var flame_trail
var base_bullet

var left_gun_1
var right_gun_1

var is_dead: bool = false


func _ready():
	flame_trail = $Ship/AnimatedSprite2D

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
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if !is_dead:
		handle_movement(delta)


func _on_health_component_health_depleted():
	is_dead = true
	$Ship.visible = false
	$explosion.visible = true
	$AnimationPlayer.play('die')
	

func die():
	queue_free()


func _on_health_component_damage_taken():
	$AnimationPlayer.play('hit')
