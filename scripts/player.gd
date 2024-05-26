extends CharacterBody2D

@export var speed = 200
@export var accel = 15

@onready var animation_player = $AnimationPlayer
@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var collision_shape_2d = $CollisionShape2D

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
			
			#if velocity.x > 0 and animation_player.flip_h:
				#animation_player.flip_h = false
			#elif velocity.x < 0 and not animation_player.flip_h:
				#animation_player.flip_h = true
			move_and_slide()
			_shrink_grow()
			
func _shrink_grow():

# TODO: Resizing Mechanic: TODO
#
#Players can change their character's size at will, shrinking to fit through tight spaces or growing to
#reach high platforms.
#Objects in the environment can also be resized, such as shrinking a boulder to move it or enlarging a 
#key to unlock a massive door.

	if Input.is_action_just_pressed("shrink_grow"): #player presses space to grow or shrink
		if scale.x == 1:
			scale.x = 2
			scale.y = 2
		else:
			scale.x = 1
			scale.y = 1

