extends Node

func quidditch_song() -> void:
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()

func standard_song() -> void:
	$AudioStreamPlayer.play()
	$AudioStreamPlayer2.stop()
