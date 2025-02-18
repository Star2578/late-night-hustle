extends Node3D

@onready var anim_player = $AnimationPlayer

var is_open: bool = true
var is_animating: bool = false  # Prevents interaction during animation

func toggle_lid():
	if anim_player.is_playing():
		return 

	is_animating = true
	if !is_open:
		is_open = true
		anim_player.play("open_lid")
	else:
		is_open = false
		anim_player.play("close_lid")

	await anim_player.animation_finished
	is_animating = false


func _on_area_3d_input_event(camera: Camera3D, event: InputEvent, event_position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !is_animating:
				toggle_lid()
