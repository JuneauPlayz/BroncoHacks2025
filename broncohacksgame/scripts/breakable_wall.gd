extends Node2D

var overlapping_areas = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("character"):
		overlapping_areas.append(area)
		if area.get_parent().dash_check == true:
			area.get_parent().dash_check == false
			queue_free()
			
func check_for_dash_hit(character):
	for area in overlapping_areas:
		if area.is_in_group("character"):
			var owner = area.get_parent()
			if character.dash_check:
				area.get_parent().dash_check == false
				queue_free()


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("character"):
		overlapping_areas.erase(area)
