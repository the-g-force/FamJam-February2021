extends Control

var target := "rover"


func _ready():
	$Label.text = "Oh no! The aliens got your "+target+"!"


func _on_Button_pressed():
	var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")
