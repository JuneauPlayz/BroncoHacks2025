extends CharacterBody2D

var game
@onready var sprite: AnimatedSprite2D = $Sprite

var SPEED = 200.0
var JUMP_VELOCITY = -350.0
var external_wind = Vector2.ZERO

@export var coyote_time_max := 0.2
var coyote_time := 0.0

@onready var hitbox: Area2D = $Hitbox

var dash_check = false
var jump_check = false
var smash_check = false

var direction 

var previous_h_state = null
var previous_v_state = null

@onready var dash_timer: Timer = $DashTimer
@onready var jump_timer: Timer = $JumpTimer
@onready var smash_timer: Timer = $SmashTimer
@onready var jump_boost_timer: Timer = $JumpBoostTimer

var powerup_timer
var current_powerup_timer
var has_powerup

func _ready():
	game = get_tree().get_first_node_in_group("game")
	powerup_timer = get_tree().get_first_node_in_group("powerup_timer")
	
func _process(delta: float) -> void:
	if has_powerup:
		powerup_timer.text = "Powerup Timer: " + str(roundi(current_powerup_timer.time_left + 0.5))
	
func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		game.add_score(1)
	
	if is_on_floor():
		coyote_time = coyote_time_max
		game.add_score(1)
	else:
		coyote_time -= delta
		
	# Handle jump.
	if game.v_state == "jump" and coyote_time > 0:
		jump(1)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if game.h_state == "forward":
		direction = 1.0
	elif game.h_state == "backward":
		direction = -1.0
	elif game.h_state == "neutral":
		direction = 0.0
	if not dash_check:
		if direction:
			if not jump_check:
				sprite.play("run")
			velocity.x = direction * SPEED
			if velocity.x < 0:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if game.h_state == "dash" and is_on_floor():
		dash(direction)
	if previous_v_state == "jump" and game.v_state == "crouch" and jump_check:
		smash()

	velocity += external_wind * delta
	##if velocity != Vector2.ZERO:
		##game.add_score(1)
	##else:
	##	sprite.play("idle")
	
	if velocity.y > 0:
		sprite.play("fall")
	
	previous_h_state = game.h_state
	previous_v_state = game.v_state
	move_and_slide()

func jump(speed):
	if is_on_floor():
		print("jumping")
		jump_check = true
		jump_timer.start()
		coyote_time = 0
		self.velocity.y = JUMP_VELOCITY * speed
		if not dash_check:
			sprite.play("jump")

func dash(direction):
	hitbox_reset()
	print("dashed")
	sprite.play("dash")
	direction = 1.0
	velocity.x = direction * SPEED * 2
	dash_check = true
	jump(0.5)
	dash_timer.start()
	for wall in get_tree().get_nodes_in_group("walls"):
		wall.check_for_dash_hit(self)
		
func smash():
	hitbox_reset()
	print("smashed")
	velocity.y = -JUMP_VELOCITY * 2
	smash_check = true
	jump_check = false
	sprite.play("smash")
	smash_timer.start()
	for floor in get_tree().get_nodes_in_group("floor"):
		floor.check_for_smash_hit(self)
	
func jump_boost(length):
	JUMP_VELOCITY *= 2
	jump_boost_timer.wait_time = length
	current_powerup_timer = jump_boost_timer
	has_powerup = true
	powerup_timer.visible = true
	jump_boost_timer.start()

func apply_wind(force):
	external_wind = force

func _on_dash_timer_timeout() -> void:
	dash_check = false
	sprite.play("run")


func _on_jump_timer_timeout() -> void:
	jump_check = false


func _on_smash_timer_timeout() -> void:
	smash_check = false
	
	


func _on_jump_boost_timer_timeout() -> void:
	JUMP_VELOCITY /= 2
	has_powerup = false
	powerup_timer.visible = false
	
func die():
	game.new_scene(game.current_level)
	
func hitbox_reset():
	hitbox.monitorable = false
	hitbox.monitorable = true
