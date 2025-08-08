extends PlayerState3D
class_name IdlePlayerState3D

static var instance: IdlePlayerState3D

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.get_axis("ui_left", "ui_right") or Input.get_axis("ui_up", "ui_down"):
		emit_signal("state_changing", WalkPlayerState3D.instance)
	
	elif Input.is_action_just_pressed("ui_select"):
		emit_signal("state_changing", JumpPlayerState3D.instance)

	#if Input.is_action_just_pressed("input_attack"):
		#emit_signal("state_changing", AttackPlayerState.instance)

func enter() -> void:
	AirAttackPlayerState.instance.enabled = true
	player.animation.play("Idle")
	player.velocity = Vector3.ZERO

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
	#if not player.is_on_floor():
		#emit_signal("state_changing", FallPlayerState.instance)
