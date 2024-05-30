extends CharacterBody2D
 
@onready var player = get_parent().find_child("player")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var hitbox = $Hitbox
@onready var hitbox_2 = $Hitbox2
@onready var animation_player = $AnimationPlayer

var direction : Vector2
var DEF = 0
 
var health = 100:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff") 

func _ready():
	set_physics_process(false)
 
func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		sprite.flip_h = true
		hitbox_2.scale.x = -1
	else:
		sprite.flip_h = false
		hitbox_2.scale.x = 1
	
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
	
	hitbox.knockback_direction = velocity.normalized()
	hitbox_2.knockback_direction = velocity.normalized()
	
func take_damage():
	health -= 10 - DEF
	
	#FIXME: Animation hurt cancels attack - just want white damage effect FIXME
	#animation_player.play("hurt")
	#Damage sound goes here
	
