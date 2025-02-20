extends Node3D

var is_open:bool = false

func open_door():
		$AnimationPlayer.play("open")
		is_open = true
func close_door():
		$AnimationPlayer.play("close")
		is_open = false


func _on_node_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not $AnimationPlayer.is_playing():
			if is_open:
				close_door()
			else:
				open_door()
