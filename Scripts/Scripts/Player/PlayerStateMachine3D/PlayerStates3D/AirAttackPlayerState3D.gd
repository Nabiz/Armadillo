extends PlayerState3D
class_name AirAttackPlayerState3D

static var instance: AirAttackPlayerState3D

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	#if abs(player.velocity.x) < 0.5:
		#emit_signal("state_changing", FallPlayerState3D.instance)
		#return

	enabled = false
	
	player.velocity.y = 0

	player.velocity = player.air_attack_speed * Vector3(player.velocity.x, 0.0, player.velocity.z).normalized()
	player.animation.speed_scale = 1.5
	player.animation.play("AirAttack")

func exit() -> void:
	player.disable_all_attack_areas()
	
	player.animation.speed_scale = 1.0
	player.velocity = player.speed * Vector3(player.velocity.x, 0.0, player.velocity.z).normalized()

func update(_delta: float) -> void:
	if not player.animation.is_playing():
		emit_signal("state_changing", FallPlayerState3D.instance)

func physics_update(_delta: float) -> void:
	pass
	#if abs(player.velocity.x) < 0.1:
		#emit_signal("state_changing", FallPlayerState3D.instance)
