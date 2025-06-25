extends PlayerState
class_name DropAttackPlayerState

static var instance: DropAttackPlayerState

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	player.velocity.x = 0.0
	player.velocity.y = -10.0
	player.animation.play("DropAttack")

func exit() -> void:
	player.disable_all_attack_areas()

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.is_on_floor():
		emit_signal("state_changing", IdlePlayerState.instance)
