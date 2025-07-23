extends Node3D

var cutscene: bool

func _ready() -> void:
	$Chair.holo = $ChairHolo
	$Chair2.holo = $ChairHolo2
	$Table.holo = $TableHolo
	$CouchCushion.holo = $CouchCushionHolo
	$CouchCushion2.holo = $CouchCushionHolo2
	$CouchCushion3.holo = $CouchCushionHolo3
	$CouchCushion4.holo = $CouchCushionHolo4
	$CouchCushion5.holo = $CouchCushionHolo5
	$CouchCushion6.holo = $CouchCushionHolo6
	$DiningChair.holo = $DiningChairHolo
	$DiningChair2.holo = $DiningChairHolo2
	$DiningChair3.holo = $DiningChairHolo3
	$DiningChair4.holo = $DiningChairHolo4
	$DiningChair5.holo = $DiningChairHolo5
	$DiningChair6.holo = $DiningChairHolo6
	$DiningChair7.holo = $DiningChairHolo7
	$DiningChair8.holo = $DiningChairHolo8
	$DiningChair9.holo = $DiningChairHolo9
	$DiningChair10.holo = $DiningChairHolo10
	$DiningChair11.holo = $DiningChairHolo11
	$DiningChair12.holo = $DiningChairHolo12
	$Pillow.holo = $PillowHolo
	


func _on_interactable_interacted(interactor: Interactor) -> void:
	if(Global.hasKey and !Global.visitedHogwarts):
		cutscene = true
		get_parent().quidditch()
