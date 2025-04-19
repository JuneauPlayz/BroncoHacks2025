extends Node2D

var overlapping_areas = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("monitoring", true)
	await get_tree().process_frame


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wall_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		if body.smash_check == true:
			body.smash_check = false
			queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("character"):
		overlapping_areas.append(area)
		if area.get_parent().smash_check == true:
			area.get_parent().smash_check = false
			queue_free()
			
func check_for_smash_hit(character):
	for area in overlapping_areas:
		if area.is_in_group("character"):
			var owner = area.get_parent()
			if owner.smash_check:
				print("Hitbox overlapping during dash!")
			


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("character"):
		overlapping_areas.erase(area)
