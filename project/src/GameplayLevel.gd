extends Control

const _ALIENS := [
	preload("res://src/Aliens/Alien1.tscn"),
	preload("res://src/Aliens/Alien2.tscn"),
]

const _FancyWord := preload("res://src/FancyWord.tscn")
const _Explosion := preload("res://src/Explosion.tscn")

var _word_bank = preload("res://src/WordBank.gd").new()
var _game_over := false
var _time_elapsed := 0.0

export var _total_time := 6.0

onready var _word := $WordBox/FancyWord
onready var _word_box := $WordBox
onready var _alien_slot := $AlienSlot
onready var _start_pos:Vector2 = $StartPos.get_global_transform().origin
onready var _end_pos:Vector2 = $EndPos.get_global_transform().origin
onready var _game_over_control := $GameOver
onready var _target := $Rover


func _ready():
	_generate_word()
	_new_alien()


func _process(delta):
	if not _game_over:
		_time_elapsed += delta/_total_time
		var pos = lerp(_start_pos, _end_pos, _time_elapsed)
		_alien_slot.position = pos
		if _time_elapsed >= 1:
			game_over()


func game_over()->void:
	_game_over = true
	var _explosion := _Explosion.instance()
	_explosion.position = _target.get_global_transform().origin
	add_child(_explosion)
	_target.queue_free()
	_game_over_control.visible = true


func _generate_word()->void:
	_word = _FancyWord.instance()
	_word.word = _word_bank.get_random_word(3)
	_word_box.add_child(_word)


func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and not _game_over:
		var the_char := char(event.unicode)
		var success : bool = _word.attempt(the_char)
		match success:
			true:
				var complete:bool = _word.is_complete()
				if complete:
					_remove_alien_sprite()
					_new_alien()
					_word_box.remove_child(_word)
					_generate_word()
			false:
				print("You failed, man!")


func _remove_alien_sprite()->void:
	_alien_slot.get_child(0).queue_free()


func _new_alien()->void:
	_time_elapsed = 0.0
	var alien:AnimatedSprite = _ALIENS[randi()%_ALIENS.size()].instance()
	_alien_slot.add_child(alien)
