extends PlayerState
class_name WalkPlayerState

static var instance: WalkPlayerState

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_select"):
		emit_signal("state_changing", JumpPlayerState.instance)

func enter() -> void:
	player.animation.play("Walk")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var p: Player = player
	if p.can_move_on_z_axis:
		p.direction = (p.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	else:
		p.velocity.z = 0
		p.direction = (p.transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	if p.direction.length() > 0:
		var target_direction: Vector3 = -p.direction
		var up: Vector3 = Vector3.UP
		var target_basis: Basis = Basis.looking_at(target_direction, up)
		p.gfx.global_transform.basis = target_basis
		
	if p.direction:
		if p.can_move_on_z_axis:
			p.velocity = p.direction * p.speed + Vector3(0.0, p.velocity.y, 0.0)
		else:
			p.velocity.x = p.direction.x * p.speed
	else:
		p.velocity.x = move_toward(p.velocity.x, 0, p.speed)
		if p.can_move_on_z_axis:
			p.velocity.z = move_toward(p.velocity.z, 0, p.speed)
	
	if not p.is_on_floor():
		emit_signal("state_changing", FallPlayerState.instance)
	
	if abs(p.direction.length_squared()) < 0.01:
		emit_signal("state_changing", IdlePlayerState.instance)
		return
