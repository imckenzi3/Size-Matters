extends Control

#@onready var menu = $Menu 
@onready var animation_player = $AnimationPlayer

func _on_play_pressed():
	animation_player.play("intro")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed():
	get_tree().quit() # default behavior

