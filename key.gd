extends Node3D

func _ready() -> void:
	if(Global.hasKey):
		queue_free()

func _on_interactable_interacted(interactor: Interactor) -> void:
	Global.hasKey = true
	queue_free()
