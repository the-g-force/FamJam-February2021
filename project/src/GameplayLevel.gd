extends Control

const _ALIENS := [
	preload("res://src/Alien1.tscn")
]


onready var _word := $FancyWord
onready var _animation_player := $AnimationPlayer
onready var _alien_slot := $AlienSlot

func _ready():
	_new_alien()


func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var the_char := char(event.unicode)
		var success : bool = _word.attempt(the_char)
		match success:
			true:
				var complete:bool = _word.is_complete()
				if complete:
					_remove_alien_sprite()
					_new_alien()
					remove_child(_word)
					_word = preload("res://src/FancyWord.tscn").instance()
					_word.word = "two"
					add_child(_word)
			false:
				print("You failed, man!")


func _remove_alien_sprite()->void:
	_alien_slot.get_child(0).queue_free()


func _new_alien()->void:
	_animation_player.stop(true)
	var alien:AnimatedSprite = _ALIENS[randi()%_ALIENS.size()].instance()
	_alien_slot.add_child(alien)
	_animation_player.play("AlienAttack")


func _on_AnimationPlayer_animation_finished(anim_name:String):
	if anim_name == "AlienAttack":
		print("You Lose!")
