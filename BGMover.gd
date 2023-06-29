extends Node2D

@export var parallax_speed = .25
var BG1
var BG2
var BG3

var bgs = [BG1, BG2, BG3]


# Called when the node enters the scene tree for the first time.
func _ready():
	BG1 = $Bg1
	BG2 = $Bg2
	BG3 = $Bg3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if BG1.position.y >= 1620:
		BG1.position = Vector2(BG1.position.x, -1619)
		
	if BG2.position.y >= 1620:
		BG2.position = Vector2(BG2.position.x, -1619)
		
	if BG3.position.y >= 1620:
		BG3.position = Vector2(BG3.position.x, -1619)

	BG1.position = Vector2(BG1.position.x, BG1.position.y + parallax_speed)
	BG2.position = Vector2(BG2.position.x, BG2.position.y + parallax_speed)
	BG3.position = Vector2(BG3.position.x, BG3.position.y + parallax_speed)

