extends Node

@export var anxiety: float = 0

var on_going_anxiety_tick = 10.0 # Increase 1 anxiety every n sec

@onready var anxiety_label = $"CanvasLayer/Anxiety/Anxiety Frame/Label"
@onready var shader_mat = $"CanvasLayer/Anxiety/Anxiety Frame".material # Assuming you applied a ShaderMaterial to the frame
@onready var init_pos = anxiety_label.position

@onready var mainmenu_display = $CanvasLayer/MainMenu
@onready var anxiety_display = $CanvasLayer/Anxiety

var is_started: bool = false

func _input(event):
	if event is InputEventKey:
		if event.is_released() and event.keycode == KEY_O:
			increase_anxiety(10)
		if event.is_released() and event.keycode == KEY_P:
			decrease_anxiety(10)

func _process(delta):
	if is_started:
		_update_ui()
		increase_anxiety(delta/ on_going_anxiety_tick)
		_anxiety_label_shaking()

func _start_game():
	is_started = true
	mainmenu_display.hide()
	anxiety_display.show()
	$CanvasLayer/MainMenu/Buttons/ClickSound.play()
	get_tree().change_scene_to_file("res://scenes/room.tscn")

func _quit_game():
	$CanvasLayer/MainMenu/Buttons/ClickSound.play()
	get_tree().quit()

func _update_ui():
	$CanvasLayer/Anxiety/AnxietyGauge.scale.x = anxiety / 100

func increase_anxiety(amount: float):
	anxiety = min(100, anxiety + amount)

func decrease_anxiety(amount: float):
	anxiety = max(0, anxiety - amount)

func _anxiety_label_shaking():
	if anxiety <= 30:
		anxiety_label.position = init_pos
		shader_mat.set_shader_parameter("intensity", 0.0)  # No effect
	elif anxiety <= 50:
		anxiety_label.position = init_pos + Vector2(randf_range(-1, 1), randf_range(-1, 1)) * 2  # Slight shaking
		shader_mat.set_shader_parameter("intensity", 0.1)  # Light distortion
	elif anxiety <= 80:
		anxiety_label.position = init_pos + Vector2(randf_range(-2, 2), randf_range(-2, 2)) * 4  # Medium shake
		shader_mat.set_shader_parameter("intensity", 0.3)  # Stronger distortion
	else:
		anxiety_label.position = init_pos + Vector2(randf_range(-4, 4), randf_range(-4, 4)) * 8  # Intense shake
		shader_mat.set_shader_parameter("intensity", 0.6)  # Max distortion
