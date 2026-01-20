extends PlayerState3D
class_name ForrwardWallrunPlayerState3D

static var instance: ForrwardWallrunPlayerState3D

var wallrun_time: float = 0.0
var max_wallrun_time: float = 0.8

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("input_jump"):
		var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if input_dir.dot(Vector2(player.direction.x, player.direction.z)) < -0.8:
			emit_signal("state_changing", JumpPlayerState3D.instance)

func enter() -> void:
	player.animation.speed_scale = 1.5
	wallrun_time = 0.0
	player.animation.play("ForrwardWallrun")
	player.velocity = Vector3.ZERO

func exit() -> void:
	player.gfx.position = Vector3.ZERO
	player.velocity = Vector3.ZERO
	player.animation.speed_scale = 1.0
	player.animation.play("RESET")
	player.animation.advance(0)

func update(delta: float) -> void:
	if not player.has_wall_on_front():
		emit_signal("state_changing", FallPlayerState3D.instance)
	wallrun_time += delta
	if wallrun_time >= max_wallrun_time:
		emit_signal("state_changing", FallPlayerState3D.instance)

func physics_update(_delta: float) -> void:
	player.velocity.y = 0.75 * player.speed
