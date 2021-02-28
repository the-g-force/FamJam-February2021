extends Node

var _word_map := {}
var _last_word := ""

func _init():
	var count := 0
	var file := File.new()
	var _ignored_error := file.open("res://assets/wordbank.tres", file.READ)
	while !file.eof_reached():
		var line := file.get_line()
		var length := line.length()
		
		# Ignore blank lines
		if length==0:
			continue
		
		if not _word_map.has(length):
			_word_map[length] = []
		_word_map[line.length()].append(line)
		count += 1
			
	print("Word bank initialized with %d words." % count)


func get_max_length()->int:
	var max_length := 0
	for length in _word_map:
		if length > max_length:
			max_length = length
	return max_length


func get_random_word(length:int)->String:
	var words = _word_map[length]
	if words==null:
		push_error("Requested length %d but it does not exist" % length)
	var finding_word := true
	var word:String = words[randi() % words.size()]
	while finding_word:
		if word != _last_word:
			finding_word = false
			_last_word = word
		else:
			word = words[randi() % words.size()]
	return word
