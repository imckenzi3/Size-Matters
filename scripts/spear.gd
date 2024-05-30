extends Hitbox
 
@onready var animated_sprite = $Sprite2D
@onready var player = get_parent().find_child("player")
 
var acceleration: Vector2 = Vector2.ZERO 
var velocity: Vector2 = Vector2.ZERO
 
var enemy_exited: bool = false

#FIXME Make spear disappear when not hit player after a set amount of time?? or
#	   Make spear go straight! FIXME

func _physics_process(delta):
 
	acceleration = (player.position - position).normalized() * 700 # vector to steer towards the player
 
	velocity += acceleration * delta
	rotation = velocity.angle() # rotate to point at player
 
	velocity = velocity.limit_length(150)
 
	position += velocity * delta
 
func _on_body_exited(_body: Node2D) -> void:
	if not enemy_exited:
		enemy_exited = true
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
		#set_collision_mask_value(3, true)
		set_collision_mask_value(4, true)

func _on_body_entered(body):
	if enemy_exited:
		if body.has_method("take_damage"):
			body.take_damage(damage, knockback_direction, knockback_force)
		queue_free()
 
