extends State
 
func enter():
	super.enter()
	animation_player.play("melee_attack")
	
func transition():
	if owner.direction.length() > 65:
		get_parent().change_state("Follow")
