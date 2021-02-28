extends HBoxContainer

const _Fancy_Letter := preload("res://src/FancyLetter.tscn")

var word:String setget _set_word

var _next_letter := 0


func _set_word(value):
	word = value.to_upper()
	_generate_word()


func _generate_word():
	for letter in word:
		var fancy_letter := _Fancy_Letter.instance()
		fancy_letter.name = letter
		fancy_letter.text = letter
		add_child(fancy_letter)
		get_child(0).call_deferred("play_next_letter_animation")


func attempt(letter:String) -> bool:
	letter = letter.to_upper()
	if letter == word[_next_letter]:
		get_child(_next_letter).play_success_animation()
		get_child(_next_letter).modulate = Color.white
		_next_letter += 1
		if not is_complete():
			get_child(_next_letter).play_next_letter_animation()
		return true
	else:
		get_child(_next_letter).play_mistake_animation()
		return false


func is_complete() -> bool:
	return _next_letter == word.length()
