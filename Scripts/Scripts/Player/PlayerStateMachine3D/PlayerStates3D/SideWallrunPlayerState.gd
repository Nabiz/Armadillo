extends PlayerState
class_name SideWallrunPlayerState

static var instance: SideWallrunPlayerState

var wallrun_time: float = 0.0
var max_wallrun_time: float = 2

var _is_right_wallrun_side: bool = false

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("input_jump"):
		#var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		#if input_dir.dot(Vector2(player.direction.x, 0.0)) < -0.8:
		emit_signal("state_changing", JumpPlayerState.instance)

func enter() -> void:
	player.animation.speed_scale = 1.5
	wallrun_time = 0.0
	player.velocity = Vector3.ZERO
	if _is_right_wallrun_side:
		player.animation.play("RightWallrun")
		player.velocity.x = -1.2*player.speed
	else:
		player.animation.play("LeftWallrun")
		player.velocity.x = 1.2*player.speed
	player.velocity.y = 2.0


func exit() -> void:
	player.velocity = Vector3.ZERO
	player.animation.speed_scale = 1.0
	player.animation.play("RESET")
	player.animation.advance(0)

func update(delta: float) -> void:
	if _is_right_wallrun_side:
		if not player.has_wall_on_right_side() or not Input.is_action_pressed("input_wallrun"):
			emit_signal("state_changing", FallPlayerState.instance)
	else:
		if not player.has_wall_on_left_side() or not Input.is_action_pressed("input_wallrun"):
			emit_signal("state_changing", FallPlayerState.instance)
	wallrun_time += delta
	if wallrun_time >= max_wallrun_time:
		emit_signal("state_changing", FallPlayerState.instance)

func physics_update(delta: float) -> void:
	player.velocity += player.get_gravity()/6 * delta

func set_right_wallrun_side() -> void:
	_is_right_wallrun_side = true
	
func set_left_wallrun_side() -> void:
	_is_right_wallrun_side = false
