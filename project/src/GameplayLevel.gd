extends Control

const _ALIENS := [
	preload("res://src/Aliens/Alien1.tscn"),
	preload("res://src/Aliens/Alien2.tscn"),
	preload("res://src/Aliens/Alien3.tscn"),
	preload("res://src/Aliens/Alien4.tscn"),
	preload("res://src/Aliens/Alien5.tscn"),
]

var _levels := [
	{"background":load("res://assets/images/mars/mars.png"), "target":load("res://assets/images/mars/rover.png"), "target name":"rover"},
	{"background":load("res://assets/images/museum/museum.png"), "target":load("res://assets/images/museum/vangoghmuseum-s0031V1962-800.png"), "target name":"painting"},
	{"background":load("res://assets/images/school/school.png"), "target":load("res://assets/images/school/dictionary.png"), "target name":"dictionary"},
]

const _FancyWord := preload("res://src/FancyWord.tscn")
const _Explosion := preload("res://src/Explosion.tscn")
const _defeat_stream := preload("res://assets/music/defeat.ogg")

enum State {
	COUNTING_DOWN,
	PLAYING,
	GAME_OVER
}

export var base_points_per_wave = 5
export var _aliens_defeated_to_advance := 3

var max_duration := Globals.max_duration
var _word_bank = preload("res://src/WordBank.gd").new()
var _state = State.COUNTING_DOWN
var _percent_alien_progress := 0.0
var _level := 3
var _aliens_defeated := 0 
var _max_level:int

onready var _word := $WordBox/FancyWord
onready var _word_box := $WordBox
onready var _alien_slot := $AlienSlot
onready var _start_pos:Vector2 = $StartPos.get_global_transform().origin
onready var _end_pos:Vector2 = $EndPos.get_global_transform().origin
onready var _game_over_control := $GameOver
onready var _target := $Target
onready var _countdown_timer := $CountdownTimer
onready var _hud := $HUD
onready var _music := $Music
onready var _background := $Background


func _ready():
	var current_level:Dictionary = _levels[randi()%_levels.size()]
	_background.texture = current_level["background"]
	_target.texture = current_level["target"]
	_game_over_control.target = current_level["target name"]
	_max_level = _word_bank.get_max_length()


func _process(delta):
	if _state == State.PLAYING:
		_percent_alien_progress += delta/max_duration
		var pos = lerp(_start_pos, _end_pos, _percent_alien_progress)
		_alien_slot.position = pos
		if _percent_alien_progress >= 1:
			game_over()


func game_over()->void:
	_state = State.GAME_OVER
	_music.stream = _defeat_stream
	_music.play()
	var _explosion := _Explosion.instance()
	_explosion.position = _target.get_global_transform().origin
	add_child(_explosion)
	_target.queue_free()
	_game_over_control.update_text()
	_game_over_control.visible = true


func _generate_word()->void:
	_word = _FancyWord.instance()
	_word.word = _word_bank.get_random_word(_level)
	_word_box.add_child(_word)


func _input(event):
	if _state != State.PLAYING:
		return
		
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var the_char := char(event.unicode)
		var success : bool = _word.attempt(the_char)
		match success:
			true:
				var complete:bool = _word.is_complete()
				if complete:
					_hud.score += base_points_per_wave + (1 - _percent_alien_progress) * max_duration
					_hud.wave += 1
					_remove_alien_sprite()
					_check_level()
					_create_new_alien()
					_word_box.remove_child(_word)
					_generate_word()


func _check_level():
	_aliens_defeated += 1
	if _aliens_defeated == _aliens_defeated_to_advance and _level < _max_level:
		_level += 1
		_aliens_defeated = 0


func _remove_alien_sprite()->void:
	_alien_slot.get_child(0).queue_free()


func _create_new_alien()->void:
	_percent_alien_progress = 0.0
	var alien:AnimatedSprite = _ALIENS[randi()%_ALIENS.size()].instance()
	_alien_slot.add_child(alien)


func _on_CountdownTimer_done():
	_countdown_timer.queue_free()
	_generate_word()
	_create_new_alien()
	_state = State.PLAYING
