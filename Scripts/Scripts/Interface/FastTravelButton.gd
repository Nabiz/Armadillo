extends Button

var _travel_spot: FastTravelArea = null

func initialize_button(travel_spot: FastTravelArea):
	_travel_spot = travel_spot
	text = travel_spot.spot_name

func _on_pressed() -> void:
	Player.instance.global_position = _travel_spot.global_position
