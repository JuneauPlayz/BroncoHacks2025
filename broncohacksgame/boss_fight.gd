extends Node2D

@onready var side_winds: Node2D = $SideWinds
@onready var top_half: Node2D = $TopHalf
@onready var bottom_half: Node2D = $BottomHalf
@onready var middle: Node2D = $Middle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_winds(false)
	toggle_bottom_half(false, 0)
	toggle_top_half(false, 0)
	toggle_middle(false, 0)
	await get_tree().create_timer(3).timeout
	toggle_winds(true)
	await get_tree().create_timer(3).timeout
	toggle_winds(false)
	toggle_bottom_half(true, 2.9)
	await get_tree().create_timer(5).timeout
	toggle_bottom_half(false, 0)
	toggle_top_half(true, 2.9)
	await get_tree().create_timer(5).timeout
	toggle_top_half(false, 0)
	toggle_winds(true)
	toggle_middle(true, 2.9)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_winds(mode: bool):
	side_winds.visible = mode
	if mode == true:
		for wind in side_winds.get_children():
			wind.enable()
	else:
		for wind in side_winds.get_children():
			wind.disable()
			
func toggle_bottom_half(mode : bool, delay : float):
	bottom_half.visible = mode
	if mode == true:
		for area in bottom_half.get_children():
			if area is not Area2D:
				area.visible = true
		await get_tree().create_timer(delay).timeout
		for area in bottom_half.get_children():
			if area is Area2D:
				area.enable()
				area.visible = true
			else:
				area.visible = false
	else:
		for area in bottom_half.get_children():
			if area is Area2D:
				area.disable()
				area.visible = false

func toggle_top_half(mode : bool, delay : float):
	top_half.visible = mode
	if mode == true:
		for area in top_half.get_children():
			if area is not Area2D:
				area.visible = true
		await get_tree().create_timer(delay).timeout
		for area in top_half.get_children():
			if area is Area2D:
				area.enable()
				area.visible = true
			else:
				area.visible = false
	else:
		for area in top_half.get_children():
			if area is Area2D:
				area.disable()
				area.visible = false
				
func toggle_middle(mode : bool, delay : float):
	middle.visible = mode
	if mode == true:
		for area in middle.get_children():
			if area is not Area2D:
				area.visible = true
		await get_tree().create_timer(delay).timeout
		for area in middle.get_children():
			if area is Area2D:
				area.enable()
				area.visible = true
			else:
				area.visible = false
	else:
		for area in middle.get_children():
			if area is Area2D:
				area.disable()
				area.visible = false
