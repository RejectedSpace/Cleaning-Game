extends Node2D

func _on_resume_button_pressed() -> void:
	Global.paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_save_button_pressed() -> void:
	Global.save()
	_on_resume_button_pressed()

func _on_load_button_pressed() -> void:
	get_tree().reload_current_scene()
	Global.paused = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()
