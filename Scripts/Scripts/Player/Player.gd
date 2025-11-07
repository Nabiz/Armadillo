extends CharacterBody3D
class_name Player

@export_category("Movement Parameters")
@export var speed: float = 5.0
@export var air_attack_speed: float = 6.0
@export var jump_velocity: float = 6.5

@export_category("Child Nodes")
@export var gfx: Node3D
@export var collision: CollisionShape3D
@export var animation: AnimationPlayer
@export var camera: Camera3D
@export var state_machine: PlayerStateMachine

@export var player_area: Area3D
@export var attack_areas: Array[PlayerAttackArea]

@export var forrward_wall_raycast: RayCast3D
@export var left_wall_raycast: RayCast3D
@export var right_wall_raycast: RayCast3D

@export_category("Transformation")
@export var player_ball: PlayerBall
@export var transformation_vfx: GPUParticles3D
@export var transformation_timer: CooldownTimer

@export_category("FSM")
@export var tooltip: Label
var is_movment3D: bool = false
var can_change_movement_strategy: bool = false
@export var state_machine_2d: PlayerStateMachine
@export var state_machine_3d: PlayerStateMachine3D

var direction: Vector3 = Vector3.ZERO

static var instance: Player

func _enter_tree() -> void:
	instance = self

func disable_destroyable_collision() -> void:
	set_collision_mask_value(2, false)

func enable_destroyable_collision() -> void:
	set_collision_mask_value(2, true)

func disable_all_attack_areas() -> void:
	for attack_area: PlayerAttackArea in attack_areas:
		attack_area.disable_attack_area()


var is_ball: bool = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("input_ball") and SkillManager.is_ball_unlcoked:
		transform_to_ball(delta)
	if can_change_movement_strategy and Input.is_action_just_pressed("input_change_state"):
		change_movment_strategy()

func transform_to_ball(delta: float) -> void:
	if is_ball and not player_ball.is_on_floor():
		return
	elif not is_on_floor():
		return
	if not transformation_timer.on_cooldown:
		transformation_timer.start_cooldown()
		if not is_ball:
			transformation_vfx.position = Vector3(0.0,0.6,0.0) + velocity * delta
			transformation_vfx.restart()
			collision.disabled = true
			gfx.visible = false
			is_ball = true
			player_ball.global_position = global_position + Vector3(0.0, 0.5, 0.0)
			player_ball.activate_ball()
			
			state_machine.set_physics_process(false)
			state_machine.set_process(false)
			velocity = Vector3.ZERO
			state_machine_2d.transit_to_new_state(FallPlayerState.instance)
			state_machine_3d.transit_to_new_state(FallPlayerState3D.instance)
		else:
			transformation_vfx.position = Vector3(0.0,0.6,0.0) + player_ball.velocity * delta
			transformation_vfx.restart()
			is_ball = false
			player_ball.deactivate_ball()
			global_position = player_ball.global_position - Vector3(0.0, 0.5, 0.0)
			state_machine.set_physics_process(true)
			state_machine.set_process(true)
			state_machine_2d.transit_to_new_state(FallPlayerState.instance)
			state_machine_3d.transit_to_new_state(FallPlayerState3D.instance)
			
			collision.disabled = false
			gfx.visible = true

func has_wall_on_front() -> bool:
	forrward_wall_raycast.force_raycast_update()
	return forrward_wall_raycast.is_colliding()

func has_wall_on_right_side() -> bool:
	right_wall_raycast.force_raycast_update()
	return right_wall_raycast.is_colliding()

func has_wall_on_left_side() -> bool:
	left_wall_raycast.force_raycast_update()
	return left_wall_raycast.is_colliding()

func enable_movement_strategy_change() -> void:
	tooltip.visible = true
	can_change_movement_strategy = true

func disable_movement_strategy_change() -> void:
	tooltip.visible = false
	can_change_movement_strategy = false

func _change_movement_strategy_to_2d() -> void:
		is_movment3D = false
		state_machine_3d.process_mode = Node.PROCESS_MODE_DISABLED
		state_machine_2d.process_mode = Node.PROCESS_MODE_INHERIT
		global_position.z = snapped(global_position.z, 5.0)
		state_machine = state_machine_2d

func _change_movement_strategy_to_3d() -> void:
		is_movment3D = true
		state_machine_2d.process_mode = Node.PROCESS_MODE_DISABLED
		state_machine_3d.process_mode = Node.PROCESS_MODE_INHERIT
		state_machine = state_machine_3d

func change_movment_strategy() -> void:
	if is_movment3D:
		_change_movement_strategy_to_2d()
	else:
		_change_movement_strategy_to_3d()
