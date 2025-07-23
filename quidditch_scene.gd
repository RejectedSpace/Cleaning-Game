extends Node3D
var cutscene: bool
@onready var snitch = $GoldenSnitch

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if(!cutscene):
		snitch.position = $Path3D/PathFollow3D.global_position
		snitch.rotation = $Path3D/PathFollow3D.rotation
		$Path3D/PathFollow3D.progress += 225*delta
	$QuidditchHud/MarginContainer/Panel/Label.text = str("FOCUS Meter:
",int($QuidditchPlayer.focus/$QuidditchPlayer.FOCUS_MAX*100),"%")

func start_cutscene() -> void:
	cutscene = true
	$AnimationPlayer.play("End")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.visitedHogwarts = true
	get_tree().change_scene_to_file("res://main.tscn")
