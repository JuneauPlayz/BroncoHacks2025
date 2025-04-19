extends Node2D

var score = 0

var current_scene
var current_level
var h_state
var v_state

var hasKey = false
@onready var score_label: Label = $Score

const MAIN_SCENE = preload("res://main scenes/main_scene.tscn")
const PICKUP_TEST = preload("res://pickup test.tscn")
const MOVING_OBJECT = preload("res://moving_object.tscn")
const LEVEL_1 = preload("res://levels/level1.tscn")
const LEVEL_2 = preload("res://levels/level2.tscn")
const LEVEL_3 = preload("res://levels/level3.tscn")
const LEVEL_4 = preload("res://levels/level4.tscn")
const LEVEL_5 = preload("res://levels/level5.tscn")
const WIN_SCREEN = preload("res://win_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_scene(LEVEL_1)

func new_scene(scene):
	if current_scene != null:
		current_scene.queue_free()
	current_level = scene
	current_scene = scene.instantiate()
	self.add_child(current_scene)


func add_score(amt):
	print(h_state)
	print(v_state)
	score += amt
	score_label.text = "Score: " + str(score)
	
func finish_level():
	hasKey = false
	match current_level:
		LEVEL_1:
			new_scene(LEVEL_2)
		LEVEL_2:
			new_scene(LEVEL_3)
		LEVEL_3:
			new_scene(LEVEL_4)
		LEVEL_4:
			new_scene(LEVEL_5)
		LEVEL_5:
			new_scene(WIN_SCREEN)
			
			
	pass
	
