extends Node3D

var is_open:bool = false
var closet_pos: Vector3 = Vector3(-1.105,0.826, 0.404)
var moving_to_closet: bool = false
var move_speed: float = 2.0

@onready var player: Camera3D = $"../Player"

func _process(delta):
	if !player.is_at_closet and is_open == true:
		close_door()
	if moving_to_closet:
		player.position = player.position.lerp(closet_pos, move_speed * delta)
		
		# Stop moving if close enough to the target
		if player.position.distance_to(closet_pos) < 0.05:
			player.position = closet_pos
			player.is_at_closet = true
			moving_to_closet = false

func open_door():
		$AnimationPlayer.play("open")
		$OpenClosetSound.play()
		is_open = true
func close_door():
		$AnimationPlayer.play("close")
		$CloseClosetSound.play()
		is_open = false

func _on_node_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not $AnimationPlayer.is_playing():
			if !player.is_at_closet:
				player.is_at_closet = false
				player.is_at_notebook = false
				player.is_at_fridge = false
				moving_to_closet = true
				return
			if is_open:
				close_door()
			else:
				open_door()


func _on_node_3d_2_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
func _on_node_3d_2_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
