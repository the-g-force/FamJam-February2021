extends Node2D


func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene("res://src/MainMenu.tscn")
