extends HBoxContainer

const _Fancy_Letter := preload("res://src/FancyLetter.tscn")

var word:String = "DOggo"

var _next_letter := 0

func _ready():
	word = word.to_upper()
	_generate_word()


func _generate_word():
	var lastpos := 0
	for letter in word:
		var fancy_letter := _Fancy_Letter.instance()
		fancy_letter.name = letter
		fancy_letter.text = letter
		add_child(fancy_letter)


func attempt(letter:String) -> bool:
	letter = letter.to_upper()
	if letter == word[_next_letter]:
		get_child(_next_letter).animate()
		_next_letter += 1
		return true
	else:
		return false


func is_complete() -> bool:
	return _next_letter == word.length()
