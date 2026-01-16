extends Node3D

var velocity: Vector3 = 10*Vector3.LEFT

func _physics_process(delta: float) -> void:
	position += delta * velocity
