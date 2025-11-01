extends Node
class_name LevelSetup

func _ready() -> void:
	SkillManager.lock_all_skills()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("input_pause"):
		PauseMenu.instance.pause()
