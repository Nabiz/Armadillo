class_name FastTravelManager
extends Node

static var travel_spots: Array[FastTravelArea]
static var ui_fast_travel: UIFastTravel

static func add_travel_spot(fta: FastTravelArea) -> void:
	travel_spots.append(fta)
