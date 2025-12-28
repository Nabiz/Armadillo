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
	
	#var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var p: Player = player
	
	p.velocity.z = 0
	#p.direction = (p.transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	#
	#if p.direction.length() > 0:
		#var target_direction: Vector3 = -p.direction
		#var up: Vector3 = Vector3.UP
		#var target_basis: Basis = Basis.looking_at(target_direction, up)
		#p.gfx.global_transform.basis = target_basis
		#
	#if p.direction:
		#p.velocity.x = p.direction.x * p.speed
	#else:
		#p.velocity.x = move_toward(p.velocity.x, 0, p.speed)
	
	p.move_and_slide()
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 0.01:
			emit_signal("state_changing", WalkPlayerState3D.instance)
		else:
			emit_signal("state_changing", IdlePlayerState3D.instance)
