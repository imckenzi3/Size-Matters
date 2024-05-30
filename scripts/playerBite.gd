extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

func _on_body_entered(body):
	body.take_damage()

func _input(event):
	if event.is_action("eat"):
		if collision_shape_2d.disabled == true:
			collision_shape_2d.disabled = false
		else:
			if collision_shape_2d.disabled == false:
				collision_shape_2d.disabled = true
	
