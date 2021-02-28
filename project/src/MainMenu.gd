extends Control

const DIFFICULTY_DURATIONS = {
	0: 20,
	1: 8,
	2: 4,
	3: 2
}

var _music_bus_index := AudioServer.get_bus_index("Music")

onready var _option_button := $DifficultyBox/OptionButton
onready var _fullscreen_toggle := $FullscreenToggle
onready var _mute_toggle := $MuteToggle

func _ready():
	# Reset the default difficulty level.
	Globals.max_duration = DIFFICULTY_DURATIONS[1]
	
	# Update the toggle buttons based on current state
	_fullscreen_toggle.pressed = OS.window_fullscreen
	_mute_toggle.pressed = AudioServer.is_bus_mute(_music_bus_index)
	
	# Set the option button theme so popups have the right font
	_option_button.theme = Theme.new()
	_option_button.theme.default_font = preload("res://src/main_menu_text.tres")


func _on_FullscreenToggle_toggled(button_pressed:bool):
	OS.window_fullscreen = button_pressed


func _on_MuteToggle_toggled(button_pressed:bool):
	AudioServer.set_bus_mute(_music_bus_index, button_pressed)


func _on_OptionButton_item_selected(index):
	Globals.max_duration = DIFFICULTY_DURATIONS[index]


func _on_PlayButton_pressed():
	var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")
