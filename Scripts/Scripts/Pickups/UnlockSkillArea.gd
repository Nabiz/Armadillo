extends Area3D

@export var skill_to_unlock: SkillManager.Skills = SkillManager.Skills.ATTACK

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		SkillManager.unlock_skill(skill_to_unlock)
		queue_free()
