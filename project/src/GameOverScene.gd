extends Control

var target := "rover"


func _ready():
	$Label.text = "Oh no! The aliens got your "+target+"!"


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")
