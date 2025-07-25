extends Area3D

@export var image: CompressedTexture2D

func _ready() -> void:
	if(Global.spillsCleanedDictionary.has(name)):
		if(Global.spillsCleanedDictionary.get(name)):
			clean()
	else:
		Global.spillsCleanedDictionary.set(name,false)
	Global.totalSpills += 1
	$Decal.texture_albedo = image

func _on_body_entered(body: Node3D) -> void:
	if body.get_parent() is Camera3D and body.get_parent().get_parent().mopActive:
		print(monitoring, monitorable)
		Global.spillsCleanedDictionary.set(name,true)
		clean()

func clean():
	visible = false
	set_deferred("monitoring", false)
	Global.spillsCleaned += 1
