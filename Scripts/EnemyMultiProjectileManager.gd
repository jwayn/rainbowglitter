extends Node2D

@export var shooting_time: float = 1.5
@export var time_between_shots: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fire_right_weapon():
	$RightWeapon.fire_weapon()
	
func fire_left_weapon():
	$LeftWeapon.fire_weapon()
	


func _on_range_collider_area_entered(area):
	$EnemyAnimations.play("shooting")
	$ShootingTimer.start(shooting_time)


func _on_shooting_timer_timeout():
	if($EnemyAnimations.is_playing()):
		print("We're stopping the shooting animation")
		$EnemyAnimations.stop()
		$ShootingTimer.start(time_between_shots)
	else:
		print("Starting shooting animation again")
		($EnemyAnimations.play("shooting"))
		$ShootingTimer.start(shooting_time)
		
