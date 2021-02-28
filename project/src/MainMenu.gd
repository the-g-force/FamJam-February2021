extends Control


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")



func _on_FullscreenToggle_toggled(button_pressed:bool):
	OS.window_fullscreen = button_pressed


func _on_MuteToggle_toggled(button_pressed:bool):
	var index := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(index, button_pressed)
