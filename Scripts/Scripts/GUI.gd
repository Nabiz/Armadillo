extends CanvasLayer
class_name GUI

var coins: int = 0
@export var coin_label: Label

func _ready() -> void:
	coin_label.text = str(coins)

func add_coin() -> void:
	print("Zebrano pieniążka!")
	coins += 1
	coin_label.text = str(coins)
