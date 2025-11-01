extends CanvasLayer
class_name PauseMenu

static var instance: PauseMenu
var main_menu_scene: PackedScene = preload("res://Scenes/Interface/Menu/MainMenu.tscn")

func _enter_tree() -> void:
	instance = self

var flag: int = 0

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("input_pause"):
		flag += 1
		if flag > 1:
			unpause()

func pause() -> void:
	get_tree().paused = true
	visible = true

func unpause() -> void:
	get_tree().paused = false
	visible = false
	flag = 0

func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)

func _on_resume_button_pressed() -> void:
	unpause()
