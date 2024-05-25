extends CharacterBody2D

@export var speed = 100
@export var accel = 10

@onready var state_machine: Node = get_node("FiniteStateMachine")


#@export var hp: int = 2: set = set_hp
signal hp_changed(new_hp)


func _physics_process(_delta: float) -> void:
			var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			
			velocity.x = move_toward(velocity.x, speed * direction.x, accel) 
			
			velocity.y = move_toward(velocity.y, speed * direction.y, accel)
			
			if velocity.x > 0 and anim_sprite.flip_h:
				anim_sprite.flip_h = false
			elif velocity.x < 0 and not anim_sprite.flip_h:
				anim_sprite.flip_h = true
			move_and_slide()
			
func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		self.hp -= dam #subtracte hp based on damage
		#frameFreeze(0.1, 0.4) #free frame (time scale, duration)
		
		#player damaged here
		#if hp > 0:
			#state_machine.set_state(state_machine.states.hurt)
			#velocity += dir * force
			##print("player hit")
		#else:
			#state_machine.set_state(state_machine.states.dead)
			#audio_stream_player_2d_dead.play()
			#velocity += dir * force * 2
			

#func frameFreeze(timeScale, duration): #call when you want to freeze "time"
	#Engine.time_scale = timeScale
	#await(get_tree().create_timer(duration * timeScale).timeout)
	#Engine.time_scale = 1.0
	
#called every time we modify the value of the hp variable
#func set_hp(new_hp: int) -> void:
	#hp = new_hp
	#emit_signal("hp_changed", new_hp)
