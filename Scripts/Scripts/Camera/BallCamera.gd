extends Camera3D

@export var object_to_look_at: Node3D

func _process(_delta: float) -> void:
	position.x = object_to_look_at.position.x
	position.y = object_to_look_at.position.y + 1.5
