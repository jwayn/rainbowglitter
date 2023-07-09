extends Node2D

@export_enum("Gun", "Bomb") var type: int = 0

var spawn_pos
var direction
var speed = 100
var gun = preload("res://Scenes/powerups/bullet_powerup.tscn")
var bomb = preload("res://Scenes/powerups/bomb_powerup.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	if type == 0:
		$Sprite2D.texture = load("res://Sprites/Powerup.png")
	if type == 1:
		$Sprite2D.texture = load("res://Sprites/Powerup_02.png")
	var l_or_r = randi() % 2
	spawn_pos = Vector2(525 if l_or_r else 1400, randi_range(0, 540))
	direction = Vector2(1 if l_or_r else -1, 1)
	position = spawn_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta


func _on_area_2d_area_entered(area):
	spawn_powerup(type)

func change_type(type):
	self.type = type
	if type == 0:
		$Sprite2D.texture = load("res://Sprites/Powerup.png")
	if type == 1:
		$Sprite2D.texture = load("res://Sprites/Powerup_02.png")

func spawn_powerup(type):
	var powerup
	if type == 0:
		#Spawn gun
		powerup = gun
	if type == 1:
		#Spawn bomb
		powerup = bomb
	var p = powerup.instantiate()
	$/root/World/Bullets.add_child(p)
	p.position = position
	queue_free()
