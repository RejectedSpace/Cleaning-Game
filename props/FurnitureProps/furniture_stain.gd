extends Area3D

func _ready() -> void:
	if(Global.stainsCleanedDictionary.has(get_path())):
		if(Global.stainsCleanedDictionary.get(get_path())):
			clean()
	else:
		Global.stainsCleanedDictionary.set(get_path(),false)
	Global.totalFurnitureStains += 1

func _on_body_entered(body: Node3D) -> void:
	if body.get_parent() is Camera3D and body.get_parent().get_parent().spongeActive:
		Global.stainsCleanedDictionary.set(get_path(),true)
		clean()

func clean():
	visible = false
	set_deferred("monitoring", false)
	Global.furnitureCleaned += 1
