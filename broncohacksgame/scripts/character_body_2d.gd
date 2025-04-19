extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var dash_check = false
var jump_check = false
var smash_check = false

@onready var dash_timer: Timer = $DashTimer
@onready var jump_timer: Timer = $JumpTimer
@onready var smash_timer: Timer = $SmashTimer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump(1)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if not dash_check:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("dash") and is_on_floor():
		dash(direction)
	if Input.is_action_just_pressed("smash") and jump_check:
		smash()
	move_and_slide()

func jump(speed):
	if is_on_floor():
		print("jumping")
		jump_check = true
		jump_timer.start()
		self.velocity.y = JUMP_VELOCITY * speed

func dash(direction):
	print("dashed")
	velocity.x = direction * SPEED * 2
	jump(0.5)
	dash_check = true
	dash_timer.start()
		
func smash():
	print("smashed")
	velocity.y = -JUMP_VELOCITY * 2
	smash_check = true
	jump_check = false
	smash_timer.start()
	
func _on_dash_timer_timeout() -> void:
	dash_check = false


func _on_jump_timer_timeout() -> void:
	jump_check = false


func _on_smash_timer_timeout() -> void:
	smash_check = false
