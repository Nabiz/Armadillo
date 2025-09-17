extends Area3D
class_name PlayerAttackArea

@export var collision: CollisionShape3D

func _ready() -> void:
	hide_vfx()
	disable_attack_area()

func enable_attack_area() -> void:
	collision.disabled = false

func disable_attack_area() -> void:
	collision.disabled = true
	hide_vfx()

func show_vfx() -> void:
	visible = true

func hide_vfx() -> void:
	visible = false
