extends Control

#@onready var menu = $Menu 

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed():
	get_tree().quit() # default behavior

