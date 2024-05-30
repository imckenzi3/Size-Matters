extends State
 
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("move")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
func transition():
	var distance = owner.direction.length()
 
	if distance < 120:
		get_parent().change_state("MeleeAttack")
	elif distance > 150:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("RangedAttack")
			#1:
				#get_parent().change_state("MeleeAttack")
