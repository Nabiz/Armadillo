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

func get_gui() -> GUI:
	return gui
