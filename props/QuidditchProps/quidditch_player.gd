extends CharacterBody3D

const FOCUS_MAX = 3
var focus = FOCUS_MAX
var focused : bool
const SPEED = 200
var running: bool
@export var world: Node3D
@onready var camera = $Camera3D
@onready var interactor = $Camera3D/PlayerInteractor

func _physics_process(delta: float) -> void:
	if(!world.cutscene):
		if Input.is_action_pressed("ui_accept"):
			velocity.y += SPEED*delta
		
		if Input.is_action_pressed("ctrl"):
			velocity.y -= SPEED*delta
		
		# Get the input direction and handle the movement/deceleration.
		var input_dir := Input.get_vector("a", "d", "w", "s")
		var direction := (transform.basis * Vector3(input_dir.x, input_dir.y*-sin(get_direction_y()), input_dir.y)).normalized()
		
		# Handles Sprinting
		if Input.is_action_just_pressed("shift"):
			running=true
		if Input.is_action_just_released("shift"):
			running=false
		
		var moveSpeed = SPEED
		
		if(running):
			moveSpeed *= 1.5
		if(Input.is_action_just_pressed("rightClick") && focus > FOCUS_MAX/10.0):
			focused = true
			focus -= FOCUS_MAX/10.0
		if(Input.is_action_pressed("rightClick") && focus > 0 && focused):
			focus -= delta
			look_toward(world.snitch.position)
		elif(focus < 0):
			focused = false
			focus = 0
		elif(focus < FOCUS_MAX):
			focused = false
			focus += delta*.3
		# Handles Movement
		if direction:
			velocity.x = direction.x * moveSpeed
			velocity.y = direction.y * moveSpeed
			velocity.z = direction.z * moveSpeed
		else:
			velocity.x = move_toward(velocity.x, 0, moveSpeed)
			velocity.y = move_toward(velocity.y, 0, moveSpeed)
			velocity.z = move_toward(velocity.z, 0, moveSpeed)
		move_and_slide()
	else:
		interactor = null
		$Camera3D/GoldenSnitch.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif(event.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if(Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if(event is InputEventMouseMotion):
			rotate_y(-event.relative.x*0.01)
			camera.rotate_x(-event.relative.y*0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func look_toward(targetPos: Vector3) -> void:
	look_at(Vector3(targetPos.x,position.y,targetPos.z),Vector3(0,1,0),false)
	var selfPos = camera.global_position
	var sign = 1
	if(selfPos.y > targetPos.y):
		sign = -1
	camera.rotation.x = sign*acos(selfPos.distance_to(Vector3(targetPos.x,selfPos.y,targetPos.z))/selfPos.distance_to(targetPos))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func get_direction_x() -> float:
	return rotation.y

func get_direction_y() -> float:
	return camera.rotation.x
