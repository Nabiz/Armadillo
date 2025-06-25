extends Area3D
class_name DestroyableStaticBody

func destroy() -> void:
	queue_free()

func _on_area_entered(area: Area3D) -> void:
	if area is PlayerAttackArea:
		visible = false
		destroy()
