extends Node2D

@export var wind_direction = Vector2(-1, 0)
@export var strength = 100.0
@export var disabled : bool = false
@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
		if body.has_method("apply_wind"):
			body.apply_wind(wind_direction * strength)


func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.has_method("apply_wind"):
			body.apply_wind(Vector2.ZERO)

func disable():
	area_2d.monitoring = false
	var character = get_tree().get_first_node_in_group("character")
	character.apply_wind(Vector2.ZERO)

func enable():
	area_2d.monitoring = true
