extends Interactor

@export var player: CharacterBody3D
var collisionBox: CollisionShape3D
var cached_closest: Interactable
var object_held: Interactable

func _ready() -> void:
	collisionBox = $CollisionShape3D

func _physics_process(delta: float) -> void:
	var new_closest: Interactable = get_closest_interactable()
	if new_closest!=cached_closest:
		if is_instance_valid(cached_closest):
			unfocus(cached_closest)
		if new_closest:
			focus(new_closest)
		cached_closest=new_closest

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e"):
		if object_held:
			interact(object_held)
			object_held=null
		elif cached_closest:
			interact(cached_closest)
			if cached_closest.grabbable:
				object_held=cached_closest

func _on_area_exited(area: Interactable) -> void:
	if cached_closest == area:
		unfocus(area)

func get_item_height() -> float:
	return collisionBox.position.y

func drop_object() -> void:
	object_held=null
