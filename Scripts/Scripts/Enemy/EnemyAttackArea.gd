extends Area3D
class_name EnemyAttackArea

@export var collision: CollisionShape3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		if body is Player:
			var player: Player = body as Player
			player.take_damage(1)
		elif body is PlayerBall:
			var player_ball: PlayerBall = body as PlayerBall
			player_ball.take_damage(1)
			

func _on_area_entered(area: Area3D) -> void:
	if area is PlayerAttackArea:
		collision.disabled = true
		get_parent().queue_free()
