extends Node

var travel_spots: Array[FastTravelArea]
var ui_fast_travel: UIFastTravel

func add_travel_spot(fta: FastTravelArea):
	travel_spots.append(fta)
	
