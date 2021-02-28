extends Control

const DIFFICULTY_DURATIONS = {
	0: 20,
	1: 8,
	2: 4,
	3: 2
}

onready var _option_button := $DifficultyBox/OptionButton


func _ready():
	_option_button.theme = Theme.new()
	_option_button.theme.default_font = preload("res://src/main_menu_text.tres")


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")



func _on_FullscreenToggle_toggled(button_pressed:bool):
	OS.window_fullscreen = button_pressed


func _on_MuteToggle_toggled(button_pressed:bool):
	var index := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(index, button_pressed)


func _on_OptionButton_item_selected(index):
	Globals.max_duration = DIFFICULTY_DURATIONS[index]
