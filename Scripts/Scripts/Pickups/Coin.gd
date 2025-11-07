extends Area3D
class_name Coin

@export var gfx: Node3D
@export var collision_shape: CollisionShape3D
@export var audio_player: AudioStreamPlayer3D

func _on_area_entered(_area: Area3D) -> void:
	audio_player.play()
	collision_shape.call_deferred("set_disabled", true)
	gfx.visible = false
	PlayerManager.instance.gui.add_coin()

func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
