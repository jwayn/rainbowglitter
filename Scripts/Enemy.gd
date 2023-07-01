extends PathFollow2D

@export var maxBulletSpeed = 5
@export var bullet = preload('res://Scenes/straight_bullet.tscn')
@export var speed = 350
@export var delayTime = 0

var bulletSpeed

var PLAYER
var playerDirection
var hasFired = false
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	PLAYER = get_node("/root/World/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_dead:
		progress += speed * delta
		if progress_ratio >= .9:
			queue_free()

func _fireAtPlayer():
	var b = bullet.instantiate()
	$/root/World/Bullets.add_child(b)
	# TODO: Figure out how to protect against race condition crash here
	b.position = $BulletPoint.global_position
	b.setTarget($BulletPoint.global_position, PLAYER.global_position)
	$ShotTimer.start(1.5)


func _on_shot_timer_timeout():
	if is_instance_valid(PLAYER) && !is_dead:
		_fireAtPlayer()
		$ShotTimer.start(1.5)


func _on_health_component_health_depleted():
	is_dead = true
	$EnemySprite.visible = false
	$Sprite2D.visible = true
	$AnimationPlayer.play('Die')


func _on_hurtbox_component_has_hurt():
	#TODO: Flash player, add invincibility timer
	pass
	
func die():
	queue_free()


func _on_health_component_damage_taken():
	$AnimationPlayer.play('hit')
