extends Node2D
@onready var character: CharacterBody2D = $Character

var rng
var speed : float
var count = 0
@onready var speed_label: Label = $Speed
@onready var wall: Node2D = $Wall


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	count += 1
	if count > 15:
		count = 0
		speed = rng.randf_range(-5.0, 5.0)
		speed = round(speed * 100) / 100.0
		speed_label.text = "Speed: " + str(speed)
		if speed > 2.0:
			#character.jump(speed)
			pass
			


func _on_wall_detection_body_entered(body: Node2D) -> void:
	if body.dash_check == true:
		wall.queue_free()


func _on_smash_timer_timeout() -> void:
	pass # Replace with function body.
