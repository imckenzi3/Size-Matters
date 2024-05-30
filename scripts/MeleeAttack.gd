extends State
 
func enter():
	super.enter()
	animation_player.play("melee_attack")
	if animation_player.is_playing(): return
	
#FIXME: Animation somtimes doesnt finish and has collision getting stuck to true FIXME
func transition():
	if owner.direction.length() > 120:
		get_parent().change_state("Follow")
