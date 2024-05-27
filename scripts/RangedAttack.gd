extends State
 
const spear_node: PackedScene = preload("res://scenes/spear.tscn")

var can_transition: bool = false
 
func enter(): #upon entering, start ranged_attack wait for animation, then shoot
	super.enter()	
	animation_player.play("ranged_attack")
	await animation_player.animation_finished
	shoot()
	can_transition = true 
 
func shoot():
	var spear = spear_node.instantiate()
	spear.position = owner.position
	get_tree().current_scene.add_child(spear) #spawn spear
	
	
func transition(): #dash transition
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash") 
