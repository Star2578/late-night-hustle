extends Camera3D

@export var edge_area: float = 50
@export var max_rotation_speed: float = 2.0
@export var deadzone_width: float = 450
@export var zoom_speed: float = 5.0
@export var min_zoom: float = 50.0
@export var max_zoom: float = 75.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			adjust_zoom(-zoom_speed)  # Zoom in
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			adjust_zoom(zoom_speed)  # Zoom out

func adjust_zoom(amount):
	# Adjusts zoom while keeping it within limits
	var new_fov = fov + amount
	fov = clamp(new_fov, min_zoom, max_zoom)

func _physics_process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().size
	
	var left_deadzone = viewport_size.x / 2 - deadzone_width / 2
	var right_deadzone = viewport_size.x / 2 + deadzone_width / 2
	
	var rotation_speed = 0.0
	
	if mouse_pos.x < left_deadzone:
		# Mouse is in the left rotation area
		rotation_speed = max_rotation_speed * (1 - (mouse_pos.x / left_deadzone))
	elif mouse_pos.x > right_deadzone:
		# Mouse is in the right rotation area
		rotation_speed = -max_rotation_speed * (1 - ((viewport_size.x - mouse_pos.x) / (viewport_size.x - right_deadzone)))
	
	rotate_y(deg_to_rad(rotation_speed))
	
	rotation_degrees.y = clamp(rotation_degrees.y, -60, 60)
