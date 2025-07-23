extends AnimatableBody3D

func _ready() -> void:
	$AnimationPlayer.play("Fly")

func _on_interactable_interacted(interactor: Interactor) -> void:
	get_parent().start_cutscene()
