extends GrabbableObject

func _process(delta: float) -> void:
	if(position.y < 0):
		position.y = 0

func _on_trash_compactor_body_entered(body: Node3D) -> void:
	if body is GrabbableObject and body.trash:
		Global.trashCleaned+=1
		body.clean(true)
	elif body is RigidBody3D:
		body.linear_velocity = -2.5*body.linear_velocity
