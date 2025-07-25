extends Marker3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		SpawnManager.instance.current_spawn_point = self
