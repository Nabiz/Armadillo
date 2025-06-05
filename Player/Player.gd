extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 6

@onready var gfx = $ArmadilloGFX
var direction:= Vector3.ZERO
var can_move_on_z_axis = false

@onready var animation = $ArmadilloGFX/AnimationPlayer
var can_interupt_animation = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if can_move_on_z_axis:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	else:
		direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	
	if direction.length() > 0:
		# Compute the target rotation
		var target_direction = -direction
		var up = Vector3.UP
		var target_basis = Basis.looking_at(target_direction, up)
		gfx.global_transform.basis = target_basis
		
	if direction:
		if can_move_on_z_axis:
			velocity = direction * SPEED
		else:
			velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if can_move_on_z_axis:
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	play_animation()

func change_movment_strategy_to_3d():
	can_move_on_z_axis = true
	velocity.z = 0

func change_movment_strategy_to_2d():
	can_move_on_z_axis = false
	velocity.z = 0


var should_roll = false
var can_wall_run = true
func play_animation():
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
