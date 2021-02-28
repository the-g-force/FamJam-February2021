extends Node2D

const _fancy_letter := preload("res://src/FancyLetter.tscn")

export var letter_distance := 10

var word:String = "DOggo"


func _ready():
	_generate_word()


func _generate_word():
	word = word.to_upper()
	var lastpos := 0
	for letter in word:
		var Fancy_Letter := _fancy_letter.instance()
		Fancy_Letter.name = letter
		Fancy_Letter.text = letter
		var wordlength := word.length()
		var wordpos := word.find(letter, lastpos)
		lastpos += 1
		var word_pos_from_middle := wordpos-wordlength/2
		var letter_pos:Vector2 = $Letters.get_global_transform().origin
		letter_pos.x += letter_distance*word_pos_from_middle
		Fancy_Letter.position = letter_pos
		$Letters.add_child(Fancy_Letter)
