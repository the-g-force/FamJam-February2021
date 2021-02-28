extends HBoxContainer

const _Fancy_Letter := preload("res://src/FancyLetter.tscn")

var word:String = "DOggo"


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
