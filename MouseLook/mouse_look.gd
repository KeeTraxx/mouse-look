class_name MouseLook

extends Node

## Target Node3D moved by the mouse. Most likely a Camera3D or parent of it.
@export var target: Node3D

## Higher means higher movements
@export var _sensivity: float = 0.25

var _total_pitch = 0.0


func _input(event: InputEvent):
	if target == null:
		return

	if event is InputEventMouseButton:
		var mouseEvent = event as InputEventMouseButton
		if mouseEvent.button_index == MOUSE_BUTTON_RIGHT:
			if mouseEvent.is_pressed():
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		var mouseEvent = event as InputEventMouseMotion
		var movement = mouseEvent.relative * _sensivity
		
		var yaw = movement.x
		var pitch = movement.y

		# Prevents looking up/down too far
		pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
		_total_pitch += pitch
	
		target.rotate_y(deg_to_rad(-yaw))
		target.rotate_object_local(Vector3.RIGHT, deg_to_rad(-pitch))
