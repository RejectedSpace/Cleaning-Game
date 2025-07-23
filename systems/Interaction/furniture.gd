extends GrabbableObject

class_name Furniture

var holo: Node3D
var fixed: bool
const positionThreshold = 2.5
const rotationThreshold = 0.5

#Override
func _ready() -> void:
	if(Global.positionsDictionary.has(name)):
		position = Global.positionsDictionary.get(name)
	if(Global.rotationsDictionary.has(name)):
		rotation = Global.rotationsDictionary.get(name)
	$Interactable.grabbable = true
	if(!Global.furnitureDictionary.has(get_path())):
		Global.totalFurniture += 1
		Global.furnitureDictionary.set(get_path(),false)

func _process(delta: float) -> void:
	holo.visible =  pickedUp
	if similar_position() and similar_rotation():
		if !fixed:
			if(!Global.furnitureDictionary.get(get_path())):
				Global.furniturePlaced += 1
				Global.furnitureDictionary.set(get_path(),true)
			position = holo.position
			rotation = holo.rotation
			fixed=true
			pickedUp=false
			freeze=true
			if(lastInteractor):
				lastInteractor.drop_object()
			set_collision_layer_value(2,true)
	else:
		if(Global.furnitureDictionary.get(get_path())):
				Global.furniturePlaced -= 1
				Global.furnitureDictionary.set(get_path(),false)
		fixed=false
		set_collision_layer_value(2,false)

func similar_position() -> bool:
	var diff = abs(position - holo.position)
	return diff.x <= positionThreshold and diff.y <= positionThreshold and diff.z <= positionThreshold

func similar_rotation() -> bool:
	var diff = abs(rotation - holo.rotation)
	return diff.x <= rotationThreshold and diff.y <= rotationThreshold and diff.z <= rotationThreshold
