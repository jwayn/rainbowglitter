extends Node2D

@export var maxBulletSpeed = 5
@export var bullet = preload('res://straight_bullet.tscn')
@export var speed = 350
@export var delayTime = 0

var bulletSpeed

var PLAYER
var playerDirection
var hasFired = false

# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER = get_node("/root/World/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().progress += speed * delta

func _fireAtPlayer():
	var b = bullet.instantiate()
	$/root/World/Bullets.add_child(b)
	b.position = $BulletPoint.global_position
	b.setTarget($BulletPoint.global_position, PLAYER.global_position)
	$ShotTimer.start(1)


func _on_shot_timer_timeout():
	if PLAYER:
		_fireAtPlayer()
		$ShotTimer.start(1)
