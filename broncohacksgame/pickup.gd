extends Node2D

@export_enum("jump_boost") var type : String
@export var length : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		match type:
			"jump_boost":
				body.jump_boost(length)
		queue_free()
