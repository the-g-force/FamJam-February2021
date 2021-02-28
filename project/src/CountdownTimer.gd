extends Label

signal done

export var duration := 3

var _remaining := duration

onready var _timer := $Timer

func _ready():
	_update_text()


func _on_Timer_timeout():
	_remaining -= 1
	_update_text()
	if _remaining == 0:
		_timer.stop()		
		emit_signal("done")
	

func _update_text()->void:
	text = "Get Ready!\n%s" % (str(_remaining) if _remaining > 0 else "")
