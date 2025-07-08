extends CharacterBody3D
class_name Player

@export_category("Movement Parameters")
@export var speed: float = 5.0
@export var air_attack_speed: float = 6.0
@export var jump_velocity: float = 6.5

@export_category("Child Nodes")
@export var gfx: Node3D
@export var collision: CollisionShape3D
@export var gui: GUI
@export var animation: AnimationPlayer
@export var camera: Camera3D
@export var state_machine: PlayerStateMachine

@export var attack_areas: Array[PlayerAttackArea]

@export_category("Ball")
@export var player_ball: PlayerBall

var direction: Vector3 = Vector3.ZERO
var can_move_on_z_axis: bool = false

func get_gui() -> GUI:
	return gui

func disable_destroyable_collision() -> void:
	set_collision_mask_value(2, false)

func enable_destroyable_collision() -> void:
	set_collision_mask_value(2, true)

func disable_all_attack_areas() -> void:
	for attack_area: PlayerAttackArea in attack_areas:
		attack_area.disable_attack_area()


var is_ball: bool = false
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace"):
		transform_to_ball()

func transform_to_ball() -> void:
	if not is_ball:
		collision.disabled = true
		gfx.visible = false
		is_ball = true
		player_ball.global_position = global_position + Vector3(0.0, 0.5, 0.0)
		player_ball.ball_camera.global_position = camera.global_position
		player_ball.activate_ball()
		
		state_machine.set_physics_process(false)
		state_machine.set_process(false)
		velocity = Vector3.ZERO
		state_machine.transit_to_new_state(FallPlayerState.instance)
	else:
		is_ball = false
		player_ball.deactivate_ball()
		global_position = player_ball.global_position - Vector3(0.0, 0.5, 0.0)
		state_machine.set_physics_process(true)
		state_machine.set_process(true)
		state_machine.transit_to_new_state(FallPlayerState.instance)
		
		collision.disabled = false
		gfx.visible = true
