extends Area3D

func _ready() -> void:
	if(Global.stainsCleanedDictionary.has(get_path())):
		if(Global.stainsCleanedDictionary.get(get_path())):
			queue_free()
	else:
		Global.totalFurnitureStains += 1
		Global.stainsCleanedDictionary.set(get_path(),false)

func _on_body_entered(body: Node3D) -> void:
	if body.get_parent() is Camera3D and body.get_parent().get_parent().spongeActive:
		Global.stainsCleanedDictionary.set(get_path(),true)
		Global.furnitureCleaned += 1
		queue_free()
