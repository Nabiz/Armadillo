extends CheckBox

@export var skill_to_unlock: SkillManager.Skills

func _ready() -> void:
	text = str(SkillManager.Skills.keys()[skill_to_unlock])

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		SkillManager.unlock_skill(skill_to_unlock)
	else:
		SkillManager.lock_skill(skill_to_unlock)
