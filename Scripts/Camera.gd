extends Camera2D

# How quickly to move through the noise
@export var NOISE_SHAKE_SPEED: float = 30.0
@export var NOISE_SWAY_SPEED: float = 1.0
# Noise returns values in the range (-1, 1)
# So this is how much to multiply the returned value by
@export var NOISE_SHAKE_STRENGTH: float = 60.0
@export var NOISE_SWAY_STRENGTH: float = 10.0
# The starting range of possible offsets using random values
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
# Multiplier for lerping the shake strength to zero
@export var SHAKE_DECAY_RATE: float = 3.0
@onready var noise = FastNoiseLite.new()
@onready var rand = RandomNumberGenerator.new()

enum ShakeType {
	RANDOM,
	NOISE,
	SWAY
}

var shake_type: int = ShakeType.RANDOM
var shake_strength: float = 0.0
var noise_i: float = 0.0


func _ready():
	rand.randomize()
	noise.seed = rand.randi()
	noise.noise_type = 1


func _process(delta):
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	
	var shake_offset: Vector2
	
	match shake_type:
		ShakeType.RANDOM:
			shake_offset = get_random_offset()
		ShakeType.NOISE:
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
		ShakeType.SWAY:
			shake_offset = get_noise_offset(delta, NOISE_SWAY_SPEED, NOISE_SWAY_STRENGTH)
	
	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	offset = shake_offset


func apply_random_shake(strength=RANDOM_SHAKE_STRENGTH) -> void:
	shake_strength = strength
	shake_type = ShakeType.RANDOM
	
func apply_noise_shake() -> void:
	shake_strength = NOISE_SHAKE_STRENGTH
	shake_type = ShakeType.NOISE

func apply_noise_sway() -> void:
	shake_type = ShakeType.SWAY

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	# Set the x values of each call to 'get_noise_2d' to a different value
	# so that our x and y vectors will be reading from unrelated areas of noise
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)
	
func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)
