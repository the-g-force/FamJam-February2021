extends Control

var target := ""


func update_text():
	$Label.text = "Oh no! The aliens got your "+target+"!"


func _on_PlayAgainButton_pressed():
	var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")


func _on_MainMenuButton_pressed():
	var _ignored := get_tree().change_scene("res://src/MainMenu.tscn")
