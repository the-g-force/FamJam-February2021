extends Control

const _Fancy_Letter := preload("res://src/FancyLetter.tscn")

var word:String setget _set_word
var _next_letter := 0

onready var _letter_box := $LetterBox


func _ready():
	_generate_word()


func _set_word(value):
	word = value.to_upper()


func _generate_word():
	for letter in word:
		var fancy_letter := _Fancy_Letter.instance()
		fancy_letter.name = letter
		fancy_letter.text = letter
		_letter_box.add_child(fancy_letter)
		_letter_box.get_child(0).call_deferred("play_next_letter_animation")


func attempt(letter:String) -> bool:
	letter = letter.to_upper()
	if letter == word[_next_letter]:
		_letter_box.get_child(_next_letter).play_success_animation()
		_letter_box.get_child(_next_letter).modulate = Color.white
		_next_letter += 1
		$CorrectSound.play()
		if not is_complete():
			_letter_box.get_child(_next_letter).play_next_letter_animation()
		return true
	else:
		_letter_box.get_child(_next_letter).play_mistake_animation()
		$MistakeSound.play()
		return false


func is_complete() -> bool:
	return _next_letter == word.length()
