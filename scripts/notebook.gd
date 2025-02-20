extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var viewport = $Node/screen2/ViewportQuad
@onready var sub_viewport = $Node/screen2/ViewportQuad/OS/SubViewport
@onready var player = $"../Player"

var notebook_pos: Vector3 = Vector3(0.54, 0.484, 1.126)
var camera: Camera3D
var move_speed: float = 2.0

var is_open: bool = false
var is_animating: bool = false  # Prevents interaction during animation
var moving_to_notebook: bool = false

func _input(event):
	if event is InputEventKey:
		sub_viewport.push_input(event)

func _ready():
	camera = get_viewport().get_camera_3d()
	viewport.material_override.albedo_texture = sub_viewport.get_texture()

func _process(delta):
	if moving_to_notebook:
		player.position = player.position.lerp(notebook_pos, move_speed * delta)
		
		# Stop moving if close enough to the target
		if player.position.distance_to(notebook_pos) < 0.05:
			player.position = notebook_pos
			player.is_at_notebook = true
			moving_to_notebook = false

func toggle_lid():
	if anim_player.is_playing():
		return 

	is_animating = true
	if !is_open:
		is_open = true
		anim_player.play("open_lid")
		$Node/screen2/ViewportQuad/OpenLidSound.play()
	else:
		is_open = false
		anim_player.play("close_lid")
		$Node/screen2/ViewportQuad/CloseLidSound.play()
		$Node/screen2/ViewportQuad/RunningSound.stop()

	await anim_player.animation_finished
	is_animating = false
	viewport.visible = is_open

func _play_notebook_running_sound():
	$Node/screen2/ViewportQuad/RunningSound.play()

func _on_area_3d_input_event(camera: Camera3D, event: InputEvent, event_position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !player.is_at_notebook:
				player.is_at_notebook = false
				player.is_at_closet = false
				moving_to_notebook = true
				return
			if !is_animating:
				toggle_lid()

func _screen_input(camera: Camera3D, event: InputEvent, event_position, normal, shape_idx):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		forward_input_to_subviewport(event, event_position)

func forward_input_to_subviewport(event: InputEvent, event_position: Vector3):
	# Convert 3D world position to 2D screen coordinates
	var local_pos = world_to_viewport_pos(event_position)
	if local_pos:
		var viewport_event = event.duplicate()
		if viewport_event is InputEventMouseButton:
			viewport_event.position = local_pos
		elif viewport_event is InputEventMouseMotion:
			viewport_event.position = local_pos
		
		sub_viewport.push_input(viewport_event)

func world_to_viewport_pos(world_pos: Vector3) -> Vector2:
	# Convert world position to local position relative to the quad
	var local_pos = viewport.to_local(world_pos)  # Convert world position to quad local space

	# Convert local position to pixel coordinates (since 1m = 500px)
	var viewport_size = sub_viewport.size
	var x_pixel = (local_pos.x / 1.4) * viewport_size.x + (viewport_size.x / 2)
	var y_pixel = (-local_pos.y / 0.9) * viewport_size.y + (viewport_size.y / 2)  # Flip Y-axis

	# Ensure it's inside the viewport bounds
	if x_pixel >= 0 and x_pixel < viewport_size.x and y_pixel >= 0 and y_pixel < viewport_size.y:
		return Vector2(x_pixel, y_pixel)
	
	return Vector2(-1, -1)  # Invalid position


func _on_area_3d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_area_3d_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
