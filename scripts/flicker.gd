extends SpotLight3D

@export var min_intensity: float = 2.0  # Minimum light intensity
@export var max_intensity: float = 10.0  # Maximum light intensity
@export var flicker_speed: float = 0.5  # How fast it flickers (lower = faster)
@export var color_variation: float = 0  # How much the color changes

var target_intensity: float
var time_until_next_flicker: float = 0.1

func _ready():
	target_intensity = light_energy  # Set initial value

func _process(delta):
	# Countdown until the next flicker
	time_until_next_flicker -= delta
	if time_until_next_flicker <= 0:
		# Pick a new target intensity and flicker time
		target_intensity = randf_range(min_intensity, max_intensity)
		time_until_next_flicker = randf_range(0.05, 0.2)  # Random delay between flickers
	
	# Smoothly transition to the new intensity
	light_energy = lerp(light_energy, target_intensity, flicker_speed)

	# (Optional) Slightly shift the light color for realism
	light_color.r += randf_range(-color_variation, color_variation) * 0.1
	light_color.g += randf_range(-color_variation, color_variation) * 0.1
	light_color.b += randf_range(-color_variation, color_variation) * 0.1

func _loop_sfx():
	$LightsSound.play()
