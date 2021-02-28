extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var word_bank := preload("res://src/WordBank.gd").new()
	print ("Did it")

