extends Area3D

@export var image: CompressedTexture2D

func _ready() -> void:
	if(Global.spillsCleanedDictionary.has(name)):
		if(Global.spillsCleanedDictionary.get(name)):
			queue_free()
	else:
		Global.totalSpills += 1
		Global.spillsCleanedDictionary.set(name,false)
	$Decal.texture_albedo = image

func _on_body_entered(body: Node3D) -> void:
	if body.get_parent() is Camera3D and body.get_parent().get_parent().mopActive:
		Global.spillsCleanedDictionary.set(name,true)
		Global.spillsCleaned += 1
		queue_free()
