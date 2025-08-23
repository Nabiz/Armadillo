extends PlayerState3D
class_name ForrwardWallrunPlayerState3D

static var instance: ForrwardWallrunPlayerState3D

var wallrun_time: float = 0.0
var max_wallrun_time: float = 0.6

func _enter_tree() -> void:
	instance = self

func handle_input(_event: InputEvent) -> void:
	pass

func enter() -> void:
	player.animation.speed_scale = 1.5
	wallrun_time = 0.0
	player.animation.play("ForrwardWallrun")
	player.velocity = Vector3.ZERO
	#if player.forrward_wall_raycast.target_position.x > 0:
		#player.gfx.rotate(Vector3.FORWARD, -PI/6)
		#player.gfx.position = Vector3(0.55, 0.6, 0.0)
	#else:
		#player.gfx.rotate(Vector3.FORWARD, PI/6)
		#player.gfx.position = Vector3(-0.55, 0.6, 0.0)

func exit() -> void:
	#if player.forrward_wall_raycast.target_position.x > 0:
		#player.gfx.rotate(Vector3.FORWARD, PI/6)
	#else:
		#player.gfx.rotate(Vector3.FORWARD, -PI/6)
	player.gfx.position = Vector3.ZERO
	player.velocity = Vector3.ZERO
	player.animation.speed_scale = 1.0
	player.animation.play("RESET")
	player.animation.advance(0)

func update(delta: float) -> void:
	if not player.has_wall_before() or not Input.is_action_pressed("input_wallrun"):
		emit_signal("state_changing", FallPlayerState3D.instance)
	wallrun_time += delta
	if wallrun_time >= max_wallrun_time:
		emit_signal("state_changing", FallPlayerState3D.instance)

func physics_update(_delta: float) -> void:
	player.velocity.y = player.speed
