extends Area3D
class_name EnemyArea

@export var damage: int = 1
@export var knockback_velocity: Vector3 = Vector3.ZERO

func _on_area_entered(_area: Area3D) -> void:
	PlayerManager.instance.take_damage(damage, knockback_velocity)
