extends CharacterBody2D

@export var speed = 100
@export var accel = 10

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var collision_shape_2d = $CollisionShape2D
@onready var player = $"."

@export var hp: int = 4: set = set_hp
@export var stam: int = 4: set = set_stam
signal hp_changed(new_hp)
signal stam_changed(new_stam)



# TODO:  Player Collision with boss melee_attack TODO
# TODO:  Player Collision with boss ranged_attack TODO
# TODO:  Player eat boss damage TODO
# TODO:  Player move sound TODO
# TODO:  Player eat sound TODO
# TODO:  Player hit sound TODO
# TODO:  Player die sound TODO
# TODO:  Player eat cheese to grow to do more damage TODO
# TODO:  boss drops cheese randomly TODO

# TODO:  Game Concept: Size Matters TODO
# Overview 
# "Size Matters" is a physics-based puzzle-platformer where players manipulate the size of their character  
# and objects to navigate through challenging environments. The core mechanic revolves around resizing  
# to solve puzzles, overcome obstacles, and explore different paths within the levels. 

# TODO:  Energy System: TODO
#
#Resizing consumes energy, which is replenished by collecting energy orbs scattered throughout the levels.
#Strategic resizing is essential, as running out of energy leaves the player unable to change size until more
#is found.

# TODO:  Environmental Interaction: TODO
#
#Certain objects react differently based on size. For example, a small character can walk on fragile surfaces
#without breaking them, while a larger character can break through barriers.
#Water behaves differently with size, allowing large characters to float and small ones to sink, adding a 
#layer of strategy to water-based puzzles.

# TODO:  Sound: TODO
#
#An adaptive soundtrack that changes with the player’s size, becoming more intense or subtle depending
#on whether the character is large or small.
#Sound effects that highlight the resizing process, such as a stretching noise for growing and a
#compressing sound for shrinking.

func _physics_process(_delta: float) -> void:
			var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			
			velocity.x = move_toward(velocity.x, speed * direction.x, accel) 
			
			velocity.y = move_toward(velocity.y, speed * direction.y, accel)
			
			if velocity.x > 0 and anim_sprite.flip_h:
				anim_sprite.flip_h = false
			elif velocity.x < 0 and not anim_sprite.flip_h:
				anim_sprite.flip_h = true
				
			move_and_slide()
			_shrink_grow()
			

func eat():
	anim_sprite.play("eat")
 
func _input(event):
	if event.is_action("eat"):
		eat()

func _shrink_grow():

# TODO: Resizing Mechanic: TODO
#
#Players can change their character's size at will, shrinking to fit through tight spaces or growing to
#reach high platforms.
#Objects in the environment can also be resized, such as shrinking a boulder to move it or enlarging a 
#key to unlock a massive door.

	if Input.is_action_just_pressed("shrink_grow"): #player presses space to grow or shrink
		if scale.x == 1:
			scale.x = 5
			scale.y = 5
		else:
			scale.x = 1
			scale.y = 1

func take_damage(dam: int, dir: Vector2, force: int) -> void:
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		#audio_stream_player_2d_hurt.play()						#audio goes here
		self.hp -= dam #subtracte hp based on damage
		frameFreeze(0.1, 0.4) #free frame (time scale, duration)
		
		#player damaged here
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force
			#print("player hit")
		else:
			state_machine.set_state(state_machine.states.dead)
			#audio_stream_player_2d_dead.play()					#audio goes here
			velocity += dir * force * 2
			

func frameFreeze(timeScale, duration): #call when you want to freeze "time"
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0
	
#called every time we modify the value of the hp variable
func set_hp(new_hp: int) -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)
	
	#called every time we modify the value of the hp variable
func set_stam(new_stam: int) -> void:
	stam = new_stam
	emit_signal("stam_changed", new_stam)
	



