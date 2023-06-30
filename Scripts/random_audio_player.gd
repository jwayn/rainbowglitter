extends Node2D
@export var sounds: Array[AudioStreamWAV]

# Called when the node enters the scene tree for the first time.
func _ready():
	for sound in sounds:
		$AudioPlayer.stream.add_stream(-1, sound)
func play_random_sound():
	$AudioPlayer.play()



