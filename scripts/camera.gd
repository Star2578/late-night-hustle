extends Camera3D

@export var edge_area: float = 50
@export var max_rotation_speed: float = 3.0
@export var deadzone_width: float = 450

var is_focus: bool = false

func _physics_process(delta):
	_focus()
	
	if is_focus: return
	
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

func _focus():
	if $"../Notebook".is_open:
		is_focus = true
		rotation.y = lerp_angle(rotation.y, 0, 0.1)
		fov = lerpf(fov, 50, 0.1)
	else:
		is_focus = false
		fov = lerpf(fov, 75, 0.1)
