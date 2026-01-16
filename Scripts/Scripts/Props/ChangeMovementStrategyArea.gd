extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		if body is Player:
			var player: Player = body as Player
			player.enable_movement_strategy_change()

func _on_body_exited(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		if body is Player:
			var player: Player = body as Player
			player.disable_movement_strategy_change()
