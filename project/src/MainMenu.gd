extends Control

const DIFFICULTY_DURATIONS = {
	0: 20,
	1: 8,
	2: 4,
	3: 2
}

var _levels := [
	{
		"background": preload("res://assets/images/mars/mars.png"),
		"target": preload("res://assets/images/mars/rover.png"), 
		"target name":"rover",
		"music": preload("res://assets/music/playing.ogg")
	},
	{
		"background": preload("res://assets/images/museum/museum.png"),
		"target": preload("res://assets/images/museum/vangoghmuseum-s0031V1962-800.png"),
		"target name":"painting",
		"music": preload("res://assets/music/daniel_theme.ogg")
	},
	{
		"background": preload("res://assets/images/school/school.png"),
		"target": preload("res://assets/images/school/dictionary.png"), 
		"target name":"dictionary",
		"music": preload("res://assets/music/SecondLevel.ogg")
	},
]

onready var _option_button := $DifficultyBox/OptionButton


func _ready():
	var _level:Dictionary = _levels[randi()%_levels.size()]
	$Sprite.texture = _level["background"]
	Globals.level = _level
	_option_button.theme = Theme.new()
	_option_button.theme.default_font = preload("res://src/main_menu_text.tres")


func _on_FullscreenToggle_toggled(button_pressed:bool):
	OS.window_fullscreen = button_pressed


func _on_MuteToggle_toggled(button_pressed:bool):
	var index := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(index, button_pressed)


func _on_OptionButton_item_selected(index):
	Globals.max_duration = DIFFICULTY_DURATIONS[index]


func _on_PlayButton_pressed():
	var _ignored := get_tree().change_scene("res://src/GameplayLevel.tscn")
