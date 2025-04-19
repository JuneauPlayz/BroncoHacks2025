extends Node2D

var score = 0

var current_scene
var h_state
var v_state

@onready var score_label: Label = $Score

const MAIN_SCENE = preload("res://main scenes/main_scene.tscn")
const PICKUP_TEST = preload("res://pickup test.tscn")
const MOVING_OBJECT = preload("res://moving_object.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_scene(MAIN_SCENE)

func new_scene(scene):
	if current_scene != null:
		current_scene.queue_free()
	current_scene = scene.instantiate()
	self.add_child(current_scene)


func add_score(amt):
	score += amt
	print(h_state)
	print(v_state)
	score_label.text = "Score: " + str(score)
	
