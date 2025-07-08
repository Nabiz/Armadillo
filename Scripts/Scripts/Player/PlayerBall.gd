extends RigidBody3D
class_name PlayerBall

var torque_accelarion: float = 30.0
var jump_force: float = 120.0
@export var ball_camera: Camera3D
@export var player: Player
@export var collision: CollisionShape3D

func _ready() -> void:
	deactivate_ball()

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		apply_torque(torque_accelarion*Vector3.BACK)
	if Input.is_action_pressed("ui_right"):
		apply_torque(torque_accelarion*Vector3.FORWARD)
	
	if Input.is_action_just_pressed("ui_select"):
		apply_impulse(jump_force * Vector3.UP)

func activate_ball() -> void:
	linear_velocity = player.velocity if player else Vector3.ZERO
	angular_velocity = Vector3.ZERO
	set_physics_process(true)
	collision.disabled = false
	visible = true
	ball_camera.make_current()

func deactivate_ball() -> void:
	set_physics_process(false)
	collision.disabled = true
	visible = false
	ball_camera.clear_current()
