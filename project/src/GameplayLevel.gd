extends Control

onready var _word := $FancyWord

var _aliens := [
	preload("res://src/Alien1.tscn")
]


func _ready():
	_new_alien()


func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_event := event as InputEventKey
		var the_char := char(event.unicode)
		var success : bool = _word.attempt(the_char)
		match success:
			true:
				var complete:bool = _word.is_complete()
				if complete:
					$Alien.get_child(0).queue_free()
					print("Alien Defeated")
					_new_alien()
				else:
					print("Yay, you can type!")
			false:
				print("You failed, man!")


func _new_alien():
	$AnimationPlayer.stop(true)
	var alien:AnimatedSprite = _aliens[randi()%_aliens.size()].instance()
	$Alien.add_child(alien)
	$AnimationPlayer.play("AlienAttack")


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "AlienAttack":
		print("You Lose!")
