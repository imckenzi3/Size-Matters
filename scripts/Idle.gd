extends State
 
@onready var collision_shape_2d = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")
 
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision_shape_2d.set_deferred("disabled", value)
		progress_bar.set_deferred("visible",value)
 
func transition():
	if player_entered:
		get_parent().change_state("Follow")
 
func _on_player_detection_body_entered(_body):
	player_entered = true

