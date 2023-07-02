extends PathFollow2D

@export var speed = 350
@export var delayTime = 0
@export var hit_confirm_sound_player: RandomAudioPlayerComponent

var is_dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_dead:
		progress += speed * delta
		if progress_ratio >= .9:
			queue_free()


func _on_health_component_health_depleted():
	is_dead = true
	$EnemySprite.visible = false
	$Sprite2D.visible = true
	$AnimationPlayer.play('Die')
	$DeathSoundPlayer.play()
	
func die():
	queue_free()


func _on_health_component_damage_taken():
	$AnimationPlayer.play('hit')


func _on_hurtbox_component_on_hit():
	$HitConfirmSoundPlayer.play()
