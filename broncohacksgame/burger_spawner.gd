extends Node2D
const MOVING_OBJECT = preload("res://moving_object.tscn")

var height = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_object = MOVING_OBJECT.instantiate()
	self.add_child(new_object)
	if height == 0:
		new_object.global_position.y += 100
		height = 1
	elif height == 1:
		new_object.global_position.y -= 100
		height = 0
