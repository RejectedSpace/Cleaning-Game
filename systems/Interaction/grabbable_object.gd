extends RigidBody3D

class_name GrabbableObject

@export var trash: bool
var pickedUp = false
var playerNode = null
var dist = 10
var lastInteractor: Interactor
var rotationOffsetY: float
var rotationQueue: Vector3
var stopSpin = false
var options = [5,4,3]
var cleaned = false

func _ready() -> void:
	$Interactable.grabbable = true

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if pickedUp:
		var playerPosition = playerNode.position
		var cameraDirection = Vector2(playerNode.get_direction_x(), playerNode.get_direction_y())
		var desiredPosition: Vector3
		desiredPosition.x = playerPosition.x - sin(cameraDirection.x)*cos(cameraDirection.y)*dist
		desiredPosition.y = playerPosition.y + lastInteractor.get_item_height() + sin(cameraDirection.y)*dist
		desiredPosition.z = playerPosition.z - cos(cameraDirection.x)*cos(cameraDirection.y)*dist
		state.linear_velocity = (desiredPosition - position)/.1
		state.transform.basis = state.transform.basis.rotated(Vector3(-sin(cameraDirection.y)*-sin(cameraDirection.x), cos(cameraDirection.y), -sin(cameraDirection.y)*-cos(cameraDirection.x)).normalized(), rotationQueue.y)
		state.transform.basis = state.transform.basis.rotated(Vector3(cos(cameraDirection.x), 0, -sin(cameraDirection.x)), rotationQueue.z)
		rotationQueue = Vector3(0, 0, 0)
		if stopSpin:
			state.angular_velocity = Vector3(0, 0, 0)
	elif(position.y < 0):
		position.y = 0

func push(distance: float) -> void:
	dist += distance
	dist = clamp(dist, 10, 25)

func pull(distance: float) -> void:
	dist -= distance
	dist = clamp(dist, 10, 25)

func rotate_y_offset(rotation: float) -> void:
	rotationOffsetY+=rotation

func _on_interactable_interacted(interactor: Interactor) -> void:
	lastInteractor = interactor
	playerNode = interactor.player
	pickedUp = !pickedUp
	freeze=false

func physics_rotate_y(val: float):
	rotationQueue.y+=val

func physics_rotate_z(val: float):
	rotationQueue.z+=val

func clean(isCleaned):
	cleaned = isCleaned
	visible = !isCleaned
	if(isCleaned):
		process_mode = PROCESS_MODE_DISABLED
	else:
		process_mode = PROCESS_MODE_INHERIT

func get_data():
	return {
		"Position" : position,
		"Rotation" : rotation,
		"Cleaned" : cleaned
	}

func load_data(data):
	position = data["Position"]
	rotation = data["Rotation"]
	clean(data["Cleaned"])
