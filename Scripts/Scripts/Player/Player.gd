extends CharacterBody3D
class_name Player

@export_category("Movement Parameters")
@export var speed: float = 5.0
@export var jump_velocity: float = 6

@export_category("Child Nodes")
@export var gfx: Node3D
@export var gui: GUI
@export var animation: AnimationPlayer

var direction: Vector3 = Vector3.ZERO
var can_move_on_z_axis: bool = false
var can_interupt_animation: bool = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if can_move_on_z_axis:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	else:
		velocity.z = 0
		direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	if direction.length() > 0:
		var target_direction: Vector3 = -direction
		var up: Vector3 = Vector3.UP
		var target_basis: Basis = Basis.looking_at(target_direction, up)
		gfx.global_transform.basis = target_basis
		
	if direction:
		if can_move_on_z_axis:
			velocity = direction * speed + Vector3(0.0, velocity.y, 0.0)
		else:
			velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if can_move_on_z_axis:
			velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	play_animation()

func change_movment_strategy_to_3d() -> void:
	can_move_on_z_axis = true
	velocity.z = 0

func change_movment_strategy_to_2d() -> void:
	can_move_on_z_axis = false
	velocity.z = 0


var should_roll: bool = false
var can_wall_run: bool = true
func play_animation() -> void:
	if Input.is_action_pressed("ui_page_down") and can_wall_run:
		can_wall_run = false
		animation.play("WallRun")
		can_interupt_animation = false

	if can_interupt_animation:
		if not is_on_floor():
			animation.play("Falling")
		else:
			if should_roll:
				should_roll = false
				animation.play("Roll")
				can_interupt_animation = false
			else:
				if direction.length_squared() > 0.1:
					animation.play("Run")
				else:
					animation.play("Idle")
	
	if velocity.y < -7:
		should_roll = true

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	can_interupt_animation = true

func get_gui() -> GUI:
	return gui
