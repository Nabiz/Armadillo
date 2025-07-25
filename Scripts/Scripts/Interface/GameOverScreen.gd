extends CanvasLayer
class_name GameOverScreen

@export var animation: AnimationPlayer
static var instance: GameOverScreen

func _enter_tree() -> void:
	instance = self

func show_gameover() -> void:
	animation.play("Fade In")
	
