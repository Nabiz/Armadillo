extends CanvasLayer

var coins = 0
@onready var coin_label = $HBoxContainer/Label

func _ready() -> void:
	coin_label.text = str(coins)

func add_coin():
	print("Zebrano pieniążka!")
	coins += 1
	coin_label.text = str(coins)
