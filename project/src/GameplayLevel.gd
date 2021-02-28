extends Control

const _ALIENS := [
	preload("res://src/Aliens/Alien1.tscn"),
	preload("res://src/Aliens/Alien2.tscn"),
]

const _FancyWord := preload("res://src/FancyWord.tscn")
const _Explosion := preload("res://src/Explosion.tscn")

var _word_bank = preload("res://src/WordBank.gd").new()
var _game_over := false

onready var _word := $WordBox/FancyWord
onready var _word_box := $WordBox
onready var _animation_player := $AnimationPlayer
onready var _alien_slot := $AlienSlot
onready var _game_over_control := $GameOver
onready var _target := $Rover


func _ready():
	_generate_word()
	_new_alien()


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
	_animation_player.stop(true)
	var alien:AnimatedSprite = _ALIENS[randi()%_ALIENS.size()].instance()
	_alien_slot.add_child(alien)
	_animation_player.play("AlienAttack")


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "AlienAttack":
		_game_over = true
		var _explosion := _Explosion.instance()
		_explosion.position = _target.get_global_transform().origin
		add_child(_explosion)
		_target.queue_free()
		_game_over_control.visible = true
