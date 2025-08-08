extends PlayerState
class_name JumpPlayerState3D

static var instance: JumpPlayerState3D

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass
	#if Input.is_action_just_pressed("input_attack"):
		#if Input.is_action_pressed("ui_down"):
			#emit_signal("state_changing", DropAttackPlayerState.instance)
		#elif Input.get_axis("ui_left", "ui_right"):
			#emit_signal("state_changing", AirAttackPlayerState.instance)

func enter() -> void:
	player.animation.play("Jump")
	player.velocity.y = player.jump_velocity

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity() * delta
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var p: Player = player
	p.direction = (p.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if p.direction.length() > 0:
		var target_direction: Vector3 = -p.direction
		var up: Vector3 = Vector3.UP
		var target_basis: Basis = Basis.looking_at(target_direction, up)
		p.gfx.global_transform.basis = target_basis
	
	if p.direction:
		p.velocity = p.direction * p.speed + Vector3(0.0, p.velocity.y, 0.0)
	else:
		p.velocity.x = move_toward(p.velocity.x, 0, p.speed)
		p.velocity.z = move_toward(p.velocity.z, 0, p.speed)
		
	#if p.direction:
		#p.velocity = p.direction * p.speed + Vector3(0.0, p.velocity.y, 0.0)
	#else:
		#p.velocity.z = move_toward(p.velocity.z, 0, p.speed)
	
	#if p.direction.x < 0:
		#player.set_forrward_wallrun_raycast_direction(raycast_vector_left)
	#else:
		#player.set_forrward_wallrun_raycast_direction(raycast_vector_right)
	#
	#if not p.is_on_floor():
		#emit_signal("state_changing", FallPlayerState.instance)
	#
	
	if player.velocity.y < 0.1:
		emit_signal("state_changing", FallPlayerState3D.instance)
		return
