extends CanvasLayer

@export var panel: Panel

func _process(_delta: float) -> void:
	if Input.is_action_just_released("F1"):
		if panel.visible:
			panel.visible = false
			panel.set_process(false)
		else:
			panel.visible = true
			panel.set_process(true)
