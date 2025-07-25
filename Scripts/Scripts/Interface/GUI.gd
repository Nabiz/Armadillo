extends CanvasLayer
class_name GUI

@export var coin_label: Label
@export var hearts_label: Label
var coins: int = 0
var hearts: int = 3

func _ready() -> void:
	coin_label.text = str(coins)
	hearts_label.text = str(hearts)

func add_coin() -> void:
	coins += 1
	coin_label.text = str(coins)

func lose_hearts(ammount: int) -> void:
	hearts -= ammount
	hearts_label.text = str(hearts)
