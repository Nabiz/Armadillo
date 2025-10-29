extends PlayerState3D
class_name FallPlayerState3D

static var instance: FallPlayerState3D

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("input_attack"):
		emit_signal("state_changing", AirAttackPlayerState3D.instance)
	elif Input.is_action_just_pressed("input_special"):
		emit_signal("state_changing", DropAttackPlayerState3D.instance)
	elif Input.is_action_just_pressed("input_jump"):
		var max_jumps: int = 2 if SkillManager.is_double_jump_unlcoked else 1
		if JumpPlayerState3D.instance.jump_count < max_jumps:
			emit_signal("state_changing", JumpPlayerState3D.instance)

func enter() -> void:
	JumpPlayerState3D.instance.jump_count+=1
	player.animation.play("Fall")

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
	
	if player.is_on_floor():
		if abs(player.velocity.x) > 0.01:
			emit_signal("state_changing", WalkPlayerState3D.instance)
		else:
			emit_signal("state_changing", IdlePlayerState3D.instance)
