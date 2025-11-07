extends CharacterBody3D
class_name PlayerBall

var accelaration: float = 3.0
var max_speed: float = 12.0
var jump_speed: float = 5.6
@export var ball_area: Area3D
@export var player: Player
@export var collision: CollisionShape3D
@export var ball_camera: Camera3D
@export var gfx_sphere: Node3D

var _jump_count: int = 1


func _ready() -> void:
	set_floor_stop_on_slope_enabled(false)
	deactivate_ball()

var rotation_speed: float = 1.0
var _rotation_axis: Vector3
var _rotation_angle: float
func _process(delta: float) -> void:
	if velocity.length_squared() > 0.001:
		_rotation_axis = Vector3.UP.cross(velocity).normalized()
		if is_on_floor():
			_rotation_angle = velocity.length() * delta * rotation_speed
		if _rotation_axis.length_squared() > 0.1:
			gfx_sphere.rotate(_rotation_axis, _rotation_angle)


func _physics_process(delta: float) -> void:
	if player.is_movment3D:
		if Input.is_action_pressed("ui_up"):
			velocity += delta*accelaration*Vector3.FORWARD
		if Input.is_action_pressed("ui_down"):
			velocity += delta*accelaration*Vector3.BACK
	
	if Input.is_action_pressed("ui_left"):
		velocity += delta*accelaration*Vector3.LEFT
	if Input.is_action_pressed("ui_right"):
		velocity += delta*accelaration*Vector3.RIGHT
		
	var velocity_plane: Vector2 = Vector2(velocity.x, velocity.z)
	if velocity_plane.length() > max_speed:
		velocity_plane = velocity_plane.normalized() * max_speed
		velocity = Vector3(velocity_plane.x as float, velocity.y, velocity_plane.y as float)
	
	if is_on_floor():
		velocity += player.get_gravity() * delta
		if SkillManager.is_double_jump_unlcoked:
			_jump_count = 2
		else:
			_jump_count = 1
	else:
		velocity += player.get_gravity() * delta
	
	if Input.is_action_just_pressed("input_jump") and _jump_count > 0:
		_jump_count -= 1
		velocity.y = jump_speed
	
	move_and_slide()


func activate_ball() -> void:
	if player.is_movment3D:
		axis_lock_angular_y = false
		axis_lock_linear_z = false
	else:
		axis_lock_angular_y = true
		axis_lock_linear_z = true
	rotation = Vector3.ZERO
	velocity = player.velocity if player else Vector3.ZERO
	set_physics_process(true)
	set_process(true)
	collision.disabled = false
	visible = true
	
	ball_camera.make_current()


func deactivate_ball() -> void:
	set_physics_process(false)
	set_process(false)
	collision.disabled = true
	visible = false
	
	ball_camera.clear_current()
