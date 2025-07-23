extends Node2D



func _on_resume_button_pressed() -> void:
	Global.paused = false
	visible = false

func _on_save_button_pressed() -> void:
	Global.save()

func _on_load_button_pressed() -> void:
	Global.load_data()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
