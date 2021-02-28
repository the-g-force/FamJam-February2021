extends Control

onready var _word := $FancyWord

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_event := event as InputEventKey
		var the_char := char(event.unicode)
		var success : bool = _word.attempt(the_char)
		print ("success" if success else "fail")
		
