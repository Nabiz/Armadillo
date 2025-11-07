extends PlayerState
class_name JumpPlayerState

static var instance: JumpPlayerState

var jump_count : int = 0

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("input_attack"):
		emit_signal("state_changing", AirAttackPlayerState.instance)
	elif Input.is_action_just_pressed("input_special"):
		emit_signal("state_changing", DropAttackPlayerState.instance)

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

	p.velocity.z = 0
	p.direction = (p.transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	if p.direction.length() > 0:
		var target_direction: Vector3 = -p.direction
		var up: Vector3 = Vector3.UP
		var target_basis: Basis = Basis.looking_at(target_direction, up)
		p.gfx.global_transform.basis = target_basis
		
	if p.direction:
		p.velocity.x = p.direction.x * p.speed
	else:
		p.velocity.x = move_toward(p.velocity.x, 0, p.speed)

	
	if player.velocity.y < 0.1:
		emit_signal("state_changing", FallPlayerState.instance)
		return

func reset_jump() -> void:
	jump_count = 0
	enabled = true
