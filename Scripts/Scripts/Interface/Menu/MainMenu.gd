extends CanvasLayer

@onready var main_scene: PackedScene = load("res://Levels/MainScene.tscn")
@onready var ball_scene: PackedScene = load("res://Levels/UnlockSkillLevels/BallLevel.tscn")

@export var menu_container: Container
@export var settings_container: Container

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_load_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(ball_scene)


func _on_settings_button_pressed() -> void:
	menu_container.visible = false
	settings_container.visible = true


func _on_save_settings_button_pressed() -> void:
	menu_container.visible = true
	settings_container.visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
