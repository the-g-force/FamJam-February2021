extends Node


func _init():
	var file := File.new()
	file.open("res://assets/wordbank.tres", file.READ)
	while !file.eof_reached():
		var line := file.get_line()
		print(line)
	print("Done!")
