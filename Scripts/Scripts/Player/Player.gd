extends CharacterBody3D
class_name Player

@export_category("Movement Parameters")
@export var speed: float = 5.0
@export var air_attack_speed: float = 6.0
@export var jump_velocity: float = 6.5

@export_category("Child Nodes")
@export var gfx: Node3D
@export var gui: GUI
@export var animation: AnimationPlayer

@export var attack_areas: Array[PlayerAttackArea]

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
