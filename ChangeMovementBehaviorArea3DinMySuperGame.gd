extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print("Super Wszedłeś w ChangeMovementBehaviorArea3DinMySuperGame")
		body.change_movment_strategy_to_3d()


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		print("Super WYSZEDŁEŚ w ChangeMovementBehaviorArea3DinMySuperGame")
		body.change_movment_strategy_to_2d()
