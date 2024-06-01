extends State

func enter():
	super.enter()
	animation_player.play("jump_attack")
	
func transition():
	if owner.direction.length() > 50:
		get_parent().change_state("Follow")
