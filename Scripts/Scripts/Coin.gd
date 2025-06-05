extends Area3D

@export var gfx: Node3D
@export var collision_shape: CollisionShape3D
@export var audio_player: AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		var player: Player = body as Player
		audio_player.play()
		collision_shape.call_deferred("set_disabled", true)
		gfx.visible = false
		player.get_gui().add_coin()

func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
