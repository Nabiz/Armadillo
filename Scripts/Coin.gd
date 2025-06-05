extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		$AudioStreamPlayer3D.play()
		$CollisionShape3D.call_deferred("set_disabled", true)
		$CoinGFX.visible = false
		body.get_node("HUD").add_coin()

func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
