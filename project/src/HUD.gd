extends ColorRect

var score := 0 setget _set_score
var wave := 1 setget _set_wave

onready var _score_label := $ScoreLabel
onready var _wave_label := $WaveLabel

func _set_score(value):
	score = value
	_score_label.text = 'Score: %d' % score


func _set_wave(value):
	wave = value
	_wave_label.text = 'Wave: %d' % wave
