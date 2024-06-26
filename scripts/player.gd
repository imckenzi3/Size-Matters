extends CharacterBody2D

@export var speed = 100
@export var accel = 40
@onready var cat_boss = $"../CatBoss"

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var collision_shape_2d = $CollisionShape2D
@onready var player = $"."
@onready var player_bite = $playerBite

@export var hp: int = 4: set = set_hp
@export var stam: int = 4: set = set_stam
signal hp_changed(new_hp)
signal stam_changed(new_stam)

var move_direction: Vector2 = Vector2.ZERO
const FRICTION: float = 0.15 

@export var knockbackPower: int = 5
const friction = 60 #friction
@onready var audio_stream_player_2d_eat = $AudioStreamPlayer2DEat
@onready var animation_player = $AnimationPlayer
@onready var joystick = $"../UI/HBoxContainer/Joystick"
@onready var eat_btn = $"../UI/HBoxContainer/EatBtn"


# TODO:  Victory Cinematic + Victory Scene? + Your are not too small! You proved me wrong! TODO
# TODO:  How to play controls TODO
# TODO:  spawn random cheese that heals the player? TODO
# TODO:  full screen TODO

func _physics_process(_delta: float) -> void:
			#var direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			#
			#velocity.x = move_toward(velocity.x, speed * direction.x, accel) 
			#
			#velocity.y = move_toward(velocity.y, speed * direction.y, accel)
		match OS.get_name():
			"iOS": #if on mobile show phone controls
				joystick.visible = true
				eat_btn.visible = true
				var direction = joystick.posVector
				if direction:
					velocity = direction * speed * 1.10
				else:
					velocity = Vector2(0,0)
			"Android": #if on mobile show phone controls
				joystick.visible = true
				eat_btn.visible = true
				var direction = joystick.posVector
				if direction:
					velocity = direction * speed * 1.10
				else:
					velocity = Vector2(0,0)
				
			"Windows":
				joystick.visible = false
				eat_btn.visible = false
				#movement - current main working player movement
				var input_dir: Vector2 = input()
				if input_dir != Vector2.ZERO: 
					accelerate(input_dir)
				else:
					add_friction()
					
				input() #player movement
				
				if velocity.x > 0 and anim_sprite.flip_h:
					anim_sprite.flip_h = false
					player_bite.scale.x = 1
				elif velocity.x < 0 and not anim_sprite.flip_h:
					anim_sprite.flip_h = true
					player_bite.scale.x = -1
					
				#move_and_slide()
				_shrink_grow()
				#
				#if stam > 0:
					#if Input.is_action_just_pressed("eat"):
						#animation_player.play("eat")
						##await animation_player.animation_finished
						#self.stam -= 1
							
				if Input.is_action_just_pressed("eat") && hp != 0:
					player.animation_player.play("eat")
					#await player.animation_player.animation_finished
					
			"Web":
				joystick.visible = false
				eat_btn.visible = false
				if OS.has_feature("mobile"):
					print_debug("has mobile")
					joystick.visible = true
					eat_btn.visible = true
				else:
					print("does not have mobile")

				#movement - current main working player movement
				var input_dir: Vector2 = input()
				if input_dir != Vector2.ZERO: 
					accelerate(input_dir)
				else:
					add_friction()
					
				input() #player movement
				
				if velocity.x > 0 and anim_sprite.flip_h:
					anim_sprite.flip_h = false
					player_bite.scale.x = 1
				elif velocity.x < 0 and not anim_sprite.flip_h:
					anim_sprite.flip_h = true
					player_bite.scale.x = -1
					
				#move_and_slide()
				_shrink_grow()
				#
				#if stam > 0:
					#if Input.is_action_just_pressed("eat"):
						#animation_player.play("eat")
						##await animation_player.animation_finished
						#self.stam -= 1
							
				if Input.is_action_just_pressed("eat") && hp != 0:
					player.animation_player.play("eat")
					#await player.animation_player.animation_finished
			
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, accel)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
#movement
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	#get input direction
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir = input_dir.normalized()
	
	#movement
	input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input_dir

func player_movement():
	move_and_slide()

func get_input() -> void:    
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP

func eat():
	animation_player.play("eat")
	#await animation_player.animation_finished
	#self.stam -= 1
	##audio_stream_player_2d_eat.play()
	#
#func _input(_event):
	#if stam != 0:
		#if Input.is_action_just_pressed("eat"):
			#eat()
			#await get_tree().create_timer(2.0).timeout

func _shrink_grow():
# TODO: Resizing Mechanic? TODO
#Players can change their character's size at will, shrinking to fit through tight spaces or growing to
#reach high platforms.
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
		#frameFreeze(0.1, 0.4) #free frame (time scale, duration)
		
		#player damaged here
		if hp > 0:
			state_machine.set_state(state_machine.states.hurt)
			velocity += dir * force * knockbackPower
		else:
			state_machine.set_state(state_machine.states.dead)
			velocity += dir * force * knockbackPower * 1.5
			#audio_stream_player_2d_dead.play()					#audio goes here

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
	
func cancel_attack() -> void:
	animation_player.play("RESET")
