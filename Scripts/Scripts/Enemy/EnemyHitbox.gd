class_name EnemyHitbox
extends Area3D

@export var enemy: CharacterBody3D

func _on_area_entered(_area: Area3D) -> void:
	enemy.queue_free()
