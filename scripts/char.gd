extends KinematicBody2D

onready var LeftRay = get_node("LR")
onready var RightRay = get_node("RR")
onready var Char = get_node("charImg")
#----------------------------------------------------------------------------

# This demo shows how to build a kinematic controller.

# Member variables
const GRAVITY = 600.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 600
const WALK_MIN_SPEED = 20
const WALK_MAX_SPEED = 300
const STOP_FORCE = 1300
const JUMP_SPEED = 1000
const JUMP_MAX_AIRBORNE_TIME = 0.4

const SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
const SLIDE_STOP_MIN_TRAVEL = 2.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false
var falling = false

var prev_jump_pressed = false

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	
	var stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		Char.play("cair")
		jumping = false
		falling = true
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		Char.play("jump")
		velocity.y = -JUMP_SPEED
		jumping = true
		falling = false
	
	on_air_time += delta
	prev_jump_pressed = jump
	
	var no_chao = LeftRay.is_colliding() or RightRay.is_colliding()
	var walking = walk_right or walk_left	
	
	
	if walking and no_chao and !jumping:
		Char.play("default")
		falling = false
	elif jumping and walking:
		Char.play("jump")
	elif !jumping and !no_chao and (walking or !walking) and falling:
		Char.play("cair")
	else:
		Char.play("default")
		Char.stop()
	
	if  walk_right:
		Char.set_flip_h(false)
	
	if walk_left:
		Char.set_flip_h(true)