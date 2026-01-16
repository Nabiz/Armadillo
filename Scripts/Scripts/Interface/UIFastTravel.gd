class_name UIFastTravel

extends CanvasLayer

var button: Button
var fast_travel_button_scene = preload("res://Scenes/Interface/FastTravel/FastTravelButton.tscn")
@export var button_container: Container

func _enter_tree() -> void:
	FastTravelManager.ui_fast_travel = self

func initialize_spot_list() -> void:
	if button_container.get_child_count() == 0:
		for spot: FastTravelArea in FastTravelManager.travel_spots:
			button = fast_travel_button_scene.instantiate()
			button_container.add_child(button)
			button.initialize_button(spot)

func focus_button():
	button.grab_focus()
