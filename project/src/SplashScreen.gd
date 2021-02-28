extends Control


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			var _ignored := get_tree().change_scene("res://src/MainMenu.tscn")
