extends State

func enter():
	super.enter()
	animation_player.play("melee_attack")
	
func transition():
	if owner.direction.length() > 140:
		get_parent().change_state("Follow")
