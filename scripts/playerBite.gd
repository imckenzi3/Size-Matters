extends Area2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $"../AnimationPlayer"
		
func _on_body_entered(body):
	body.take_damage()

#func _input(event):
	#if event.is_action("eat") && not animation_player.is_playing():
		#collision_shape_2d.disabled = false
	#else:
		#collision_shape_2d.disabled = true
		
		#if animation_player.is_playing():
			#collision_shape_2d.disabled = true
		#else:
			#collision_shape_2d.disabled = false
				#
			#if collision_shape_2d.disabled == true:
				#
				#collision_shape_2d.disabled = false
			#else:
				#if collision_shape_2d.disabled == false:
					#collision_shape_2d.disabled = true
	#
