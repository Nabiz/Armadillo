class_name FastTravelArea
extends Area3D

var can_teleport: bool = false
@export var spot_name: String = "Leśna Kraina"

func _ready() -> void:
	FastTravelManager.add_travel_spot(self)

func _input(event: InputEvent) -> void:
	if can_teleport and event.is_action_pressed("input_change_state"):
		if !FastTravelManager.ui_fast_travel.visible:
			get_tree().paused = true
			FastTravelManager.ui_fast_travel.initialize_spot_list()
			FastTravelManager.ui_fast_travel.show()
			FastTravelManager.ui_fast_travel.focus_button()
		else:
			get_tree().paused = false
			FastTravelManager.ui_fast_travel.hide()


func _on_area_entered(_area: Area3D) -> void:
	Player.instance.tooltip.show()
	can_teleport = true


func _on_area_exited(_area: Area3D) -> void:
		Player.instance.tooltip.hide()
		can_teleport = false
		FastTravelManager.ui_fast_travel.hide()
