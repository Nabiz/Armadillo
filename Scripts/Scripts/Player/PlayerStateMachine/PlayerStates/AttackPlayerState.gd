extends PlayerState
class_name AttackPlayerState

static var instance: AttackPlayerState

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	player.animation.speed_scale = 2.0
	player.animation.play("Attack")
	player.velocity = Vector3.ZERO

func exit() -> void:
	player.disable_all_attack_areas()
	player.animation.speed_scale = 1.0

func update(_delta: float) -> void:
	if not player.animation.is_playing():
		if Input.get_axis("ui_left", "ui_right"):
			emit_signal("state_changing", WalkPlayerState.instance)
		else:
			emit_signal("state_changing", IdlePlayerState.instance)

func physics_update(_delta: float) -> void:
	pass
