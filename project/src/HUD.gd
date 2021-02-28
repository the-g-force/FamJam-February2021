class_name HUD
extends HBoxContainer

var score := 0 setget _set_score
var wave := 1 setget _set_wave

func _set_score(value):
	score = value
	$ScoreLabel.text = 'Score: %d' % score


func _set_wave(value):
	wave = value
	$WaveLabel.text = 'Wave: %d' % wave
