extends Area3D
class_name EnemyAttackArea

@export var damage: int = 1
@export var side_knockback_speed: float = 0
@export var up_knockback_speed: float = 3

func _on_area_entered(area: Area3D) -> void:
	var direction: Vector3 = area.global_position - global_position
	direction = Vector3(direction.x, 0.0, direction.z).normalized()
	
	var knockback_velocity: Vector3 = side_knockback_speed * direction + \
	Vector3(0.0, up_knockback_speed, 0.0)
	
	PlayerManager.instance.take_damage(damage, knockback_velocity)
