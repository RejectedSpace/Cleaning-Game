extends CharacterBody3D

const SPEED = 40
const POSTURE_MULTIPLIER = 1.67
const JUMP_VELOCITY = 65
var crouched: bool
var running: bool
var lightOn: bool
var turn_mode: bool
var toolIndex: int
var lastTool: int
var mopActive: bool
var spongeActive: bool
@export var world: Node3D
@onready var camera = $Camera3D
@onready var playerAnimator = $AnimationPlayer
@onready var cameraAnimator = $Camera3D/AnimationPlayer
@onready var flashlight = $Camera3D/SpotLight3D
@onready var flashlightAnimator = $Camera3D/SpotLight3D/AnimationPlayer
@onready var interactor = $Camera3D/PlayerInteractor

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 20
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Handles Flashlight Input
	if Input.is_action_just_pressed("f"):
		lightOn=!lightOn
		if lightOn:
			flashlight.visible=true
			flashlight.spot_angle_attenuation=3
			flashlight.light_energy=4
		else:
			flashlightAnimator.play("TurnOff")
	
	# Handles Crouching
	if Input.is_action_just_pressed("ctrl"):
		crouched=true
		playerAnimator.play("Crouch")
	if Input.is_action_just_released("ctrl"):
		crouched=false
		playerAnimator.play("Uncrouch")
	
	# Handles Sprinting
	if Input.is_action_just_pressed("shift"):
		running=true
	if Input.is_action_just_released("shift"):
		running=false
	
	# Sets Move Speed
	var moveSpeed=SPEED
	if crouched:
		moveSpeed/=POSTURE_MULTIPLIER
	elif running:
		moveSpeed*=POSTURE_MULTIPLIER
	
	# Handles Movement
	if direction:
		velocity.x = direction.x * moveSpeed
		velocity.z = direction.z * moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)
		velocity.z = move_toward(velocity.z, 0, moveSpeed)
	move_and_slide()
	
	# Handles Bobbing animation
	var movement=get_real_velocity()
	cameraAnimator.speed_scale=moveSpeed/SPEED
	if movement.x+movement.y+movement.z!=0 && !is_on_floor():
		cameraAnimator.play("Bob")
	else:
		cameraAnimator.play("RESET")
	
	if(interactor.object_held):
		if(Input.is_action_just_released("scrollDown")):
			interactor.object_held.object.pull(100*delta)
		elif(Input.is_action_just_released("scrollUp")):
			interactor.object_held.object.push(100*delta)
		
		turn_mode=Input.is_action_pressed("rightClick")
		interactor.object_held.object.stopSpin=Input.is_action_pressed("rightClick")
	
	if(Input.is_action_just_pressed("0") && toolIndex != 0):
		reset_tools()
		lastTool=toolIndex
		toolIndex = 0
	if(Input.is_action_just_pressed("1")):
		reset_tools()
		lastTool = toolIndex
		if(toolIndex == 1):
			toolIndex = 0
		else:
			toolIndex = 1
	if(Input.is_action_just_pressed("2")):
		reset_tools()
		lastTool = toolIndex
		if(toolIndex == 2):
			toolIndex = 0
		else:
			toolIndex = 2
	if(Input.is_action_just_pressed("q")):
		reset_tools()
		var temp = toolIndex
		toolIndex = lastTool
		lastTool = temp
	$Camera3D/Mop.visible = toolIndex == 1
	$Camera3D/Mop/CollisionShape3D.disabled = toolIndex != 1
	$Camera3D/Sponge.visible = toolIndex == 2
	$Camera3D/Sponge/CollisionShape3D.disabled = toolIndex != 2
	if(Input.is_action_just_pressed("leftClick")):
		if(toolIndex == 1):
			$Camera3D/Mop/AnimationPlayer.play("Mop")
		elif(toolIndex == 2):
			$Camera3D/Sponge/AnimationPlayer.play("Sponge")
	mopActive = $Camera3D/Mop/AnimationPlayer.is_playing()
	spongeActive = $Camera3D/Sponge/AnimationPlayer.is_playing()

func _unhandled_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif(event.is_action_pressed("ui_cancel")):
		if(Global.paused):
			get_parent().close_menu()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_parent().open_menu()
	if(Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if(event is InputEventMouseMotion):
			if(turn_mode_enabled() and interactor.object_held):
				interactor.object_held.object.physics_rotate_y(event.relative.x*0.01)
				interactor.object_held.object.physics_rotate_z(event.relative.y*0.01)
			else:
				if(interactor.object_held):
					interactor.object_held.object.physics_rotate_y(-event.relative.x*0.01)
				rotate_y(-event.relative.x*0.01)
				camera.rotate_x(-event.relative.y*0.01)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))

func reset_tools() -> void:
	$Camera3D/Mop/AnimationPlayer.play("RESET")
	$Camera3D/Sponge/AnimationPlayer.play("RESET")

func turn_mode_enabled() -> bool:
	return turn_mode

func get_direction_x() -> float:
	return rotation.y

func get_direction_y() -> float:
	return camera.rotation.x

func get_data():
	return {
		"Position" : position,
		"RotationY" : rotation.y,
		"RotationX" : $Camera3D.rotation.x,
		"Interactor" : interactor.get_data()
	}

func load_data(data):
	position = data["Position"]
	rotation.y = data["RotationY"]
	$Camera3D.rotation.x = data["RotationX"]
	interactor.load_data(data["Interactor"])
