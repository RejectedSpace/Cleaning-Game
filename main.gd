extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.load_data()
	AudioManager.standard_song()
	if(Global.visitedHogwarts):
		$GoldenSnitch.visible=false
		$Broom.visible=false
		$Broom2.visible=false
		$BrownLabubu.visible=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/HUD.setText(str("Trash Cleaned: ",Global.trashCleaned,"/",Global.totalTrash,"
Furniture Placed: ",Global.furniturePlaced,"/",Global.totalFurniture,"
Furniture Cleaned: ",Global.furnitureCleaned,"/",Global.totalFurnitureStains,"
Spills Cleaned: ", Global.spillsCleaned,"/", Global.totalSpills))

func quidditch() -> void:
	Global.save()
	AudioManager.quidditch_song()
	$AnimationPlayer.play("Quidditch")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "Quidditch"):
		get_tree().change_scene_to_file("res://quidditch_scene.tscn")

func open_menu() -> void:
	$CanvasLayer/Menu.visible=true
	Global.paused = true
