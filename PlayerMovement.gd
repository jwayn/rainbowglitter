extends Node2D


@export var move_speed = 150.0
@export var fire_rate = .125
var is_moving = false
var flame_trail
var base_bullet

var can_fire = true
var left_gun_1
var right_gun_1


func _ready():
	flame_trail = $Ship/AnimatedSprite2D
	base_bullet = load("res://player_base_bullet.tscn")
	left_gun_1 = $"Left Gun 1"
	right_gun_1 = $"Right Gun 1"

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
		
	if Input.is_action_pressed("ui_accept"):
		_fire_weapon()

	# We are moving if our direction vector isn't 0,0
	if direction != Vector2(0,0):
		is_moving = true
	else:
		is_moving = false
	
	position += direction.normalized() * move_speed * delta
	if is_moving:
		flame_trail.scale.y = 1
		flame_trail.position.y = 24
	else:
		flame_trail.scale.y = .25
		flame_trail.position.y = 18.709

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	handle_movement(delta)
	
func _fire_weapon():
	if can_fire:
		var b1 = base_bullet.instantiate()
		var b2 = base_bullet.instantiate()
		$/root/World/Bullets.add_child(b1)
		$/root/World/Bullets.add_child(b2)
		b1.position = left_gun_1.global_position
		b2.position = right_gun_1.global_position
		can_fire = false
		$FireTimer.start(fire_rate)


func _on_fire_timer_timeout():
	can_fire = true
