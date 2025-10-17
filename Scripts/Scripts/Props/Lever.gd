extends StaticBody3D
class_name Lever

@export var turn_on: bool = false
@export var handle: MeshInstance3D
@export var handle_collision: CollisionShape3D
var _handle_off_rotation: float = -45
var _handle_on_rotation: float = 45

@export var barrier_array: Array[Barrier]

func _ready() -> void:
	if turn_on:
		handle.rotation.x = _handle_on_rotation
	else:
		handle.rotation.x = _handle_off_rotation

func _on_handle_area_3d_body_entered(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		var relative_x: float = body.global_position.x-handle_collision.global_position.x
		if (relative_x < 0 and !turn_on) or (relative_x > 0 and turn_on):
			switch_laver()

func switch_laver() -> void:
	turn_on = !turn_on
	if turn_on:
		handle.rotation.x = _handle_on_rotation
		for barrier: Barrier in barrier_array:
			barrier.open()
	else:
		handle.rotation.x = _handle_off_rotation
		for barrier: Barrier in barrier_array:
			barrier.close()
	
