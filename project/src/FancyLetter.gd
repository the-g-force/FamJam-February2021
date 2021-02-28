extends Label

const _FONT_DATA := preload("res://assets/fonts/DMMono-Regular.ttf")

onready var _animation_player := $AnimationPlayer

func _ready():
	# Each letter needs its own font so that they can be independently
	# animated (e.g. change the size of one and not the others)
	var font = DynamicFont.new()
	font.font_data = _FONT_DATA
	font.size = 32
	font.outline_size = 2
	font.outline_color = Color.orange
	add_font_override("font", font)


func play_next_letter_animation()->void:
	_animation_player.play("next_letter")


func play_success_animation()->void:
	_animation_player.play_backwards("next_letter")
