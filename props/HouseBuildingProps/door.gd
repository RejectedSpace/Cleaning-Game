extends AnimatableBody3D

var opened=false
@export var boarded = false
@export var locked=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_interacted(interactor: Interactor) -> void:
	if !boarded and (!locked or Global.hasKey):
		locked = false
		opened = !opened
		if opened:
			$AnimationPlayer.play("Open")
		else:
			$AnimationPlayer.play("Close")
	else:
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("LockJiggle")
