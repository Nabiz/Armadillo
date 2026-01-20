extends PlayerState3D
class_name KnockbackPlayerState3D

static var instance: KnockbackPlayerState3D

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	player.animation.play("Fall")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta

	var p: Player = player
	
	p.velocity.z = 0
	
	p.move_and_slide()
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 0.01:
			emit_signal("state_changing", WalkPlayerState3D.instance)
		else:
			emit_signal("state_changing", IdlePlayerState3D.instance)
