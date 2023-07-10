extends Node2D

var speed = 150
var markers: Array
var current_target_position: Vector2
var at_target_position = false
var initial_spawn = true
var live_guns = 6
var menu_scene
var is_dying = false
# Called when the node enters the scene tree for the first time.
func _ready():
	markers = $/root/World/boss_markers.get_children()
	current_target_position = markers[0].position
	menu_scene = load("res://credits.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_towards_target_position(delta)
	
	if live_guns <= 0:
		explode_and_die()

func move_towards_target_position(delta):
	var direction = position.direction_to(current_target_position)
	position += speed * delta * direction
	if is_dying:
		$/root/World/Camera.apply_noise_shake_override(60)

	if initial_spawn:
		$/root/World/Camera.apply_noise_shake_override(15)
	
	if position.distance_to(current_target_position) <= 2:
		initial_spawn = false
		at_target_position = true
		current_target_position = pick_random_target_position()

func pick_random_target_position():
	return markers[randi() % markers.size()].position


func _lg1_on_health_component_health_depleted():
	pass # Replace with function body.


func _on_big_gun_gun_died():
	print("Gun died!")
	live_guns -= 1
	print(live_guns)

func explode_and_die():
	print('Exploding then dying')
	is_dying = true
	$AnimationPlayer.play("explosions_1")

func die():
	get_tree().change_scene_to_packed(menu_scene)
