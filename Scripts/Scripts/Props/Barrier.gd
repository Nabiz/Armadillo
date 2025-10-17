extends StaticBody3D
class_name Barrier

var is_open: bool = false
@export var gfx: Node3D
@export var collision: CollisionShape3D

func open() -> void:
	is_open = true
	gfx.visible = false
	collision.disabled = true

func close() -> void:
	is_open = false
	gfx.visible = true
	collision.disabled = false
