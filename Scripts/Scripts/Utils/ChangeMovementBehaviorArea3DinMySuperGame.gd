extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body as Player
		player.change_movment_strategy_to_3d()


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		var player: Player = body as Player
		player.change_movment_strategy_to_2d()
