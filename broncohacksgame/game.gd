extends Node2D

var score = 0

var current_scene
var current_level
var h_state
var v_state
var dash_state

var hasKey = false

@onready var has_key_visual: Area2D = $CanvasLayer/HasKey

@onready var h_state_label: Label = $CanvasLayer/H_STATE_LABEL
@onready var v_state_label: Label = $CanvasLayer/V_STATE_LABEL
@onready var dash_state_label: Label = $CanvasLayer/DASH_STATE_LABEL

@onready var score_label: Label = $CanvasLayer/Score

const MAIN_SCENE = preload("res://main scenes/main_scene.tscn")
const PICKUP_TEST = preload("res://pickup test.tscn")
const MOVING_OBJECT = preload("res://moving_object.tscn")
const LEVEL_1 = preload("res://levels/level1.tscn")
const LEVEL_2 = preload("res://levels/level2.tscn")
const LEVEL_3 = preload("res://levels/level3.tscn")
const LEVEL_4 = preload("res://levels/level4.tscn")
const LEVEL_5 = preload("res://levels/level5.tscn")
const WIN_SCREEN = preload("res://win_screen.tscn")
const START_SCREEN = preload("res://start_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_scene(START_SCREEN)

func _process(delta : float) -> void:
	if h_state != null:
		h_state_label.text = h_state
	if v_state != null:
		v_state_label.text = v_state

	if dash_state != null:
		dash_state_label.text = dash_state


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
	has_key_visual.visible = false
	match current_level:
		START_SCREEN:
			new_scene(LEVEL_1)
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
	
