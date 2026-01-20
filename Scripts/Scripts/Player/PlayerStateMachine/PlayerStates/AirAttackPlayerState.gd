extends PlayerState
class_name AirAttackPlayerState

static var instance: AirAttackPlayerState

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	enabled = false
	
	player.velocity.y = 0

	if player.velocity.x >= 0.1:
		player.velocity.x = player.air_attack_speed
	elif player.velocity.x <= -0.1:
		player.velocity.x = -player.air_attack_speed
	player.animation.speed_scale = 1.5
	player.animation.play("AirAttack")

func exit() -> void:
	player.disable_all_attack_areas()
	
	player.animation.speed_scale = 1.0
	player.velocity.x = player.speed

func update(_delta: float) -> void:
	if not player.animation.is_playing():
		emit_signal("state_changing", FallPlayerState.instance)

func physics_update(_delta: float) -> void:
	pass
