extends CanvasLayer
class_name GUI

@export var coin_label: Label
var coins: int = 0

func _ready() -> void:
	coin_label.text = str(coins)

func add_coin() -> void:
	coins += 1
	coin_label.text = str(coins)
