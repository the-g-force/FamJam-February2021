extends Label

onready var _animation_player := $AnimationPlayer

func _ready():
	# Each letter needs its own font so that they can be independently
	# animated (e.g. change the size of one and not the others)
	var font = DynamicFont.new()
	font.font_data = preload("res://assets/fonts/Roboto-Medium.ttf")
	add_font_override("font", font)


func animate():
	_animation_player.play("Awful")
