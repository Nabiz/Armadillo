extends Area3D
class_name Coin

@export var gfx: Node3D
@export var collision_shape: CollisionShape3D
@export var audio_player: AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player or body is PlayerBall:
		audio_player.play()
		collision_shape.call_deferred("set_disabled", true)
		gfx.visible = false
		if body is Player:
			var player: Player = body as Player
			player.get_gui().add_coin()
		elif body is PlayerBall:
			var player_ball: PlayerBall = body as PlayerBall
			player_ball.player.get_gui().add_coin()
			
func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
