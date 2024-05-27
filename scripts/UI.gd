extends CanvasLayer

const MIN_HEALTH: int = 0 #store min health

var max_hp: int = 4
var max_stam: int = 3

@onready var player: CharacterBody2D = get_parent().get_node("player")#ref to player 
@onready var health_bar: TextureProgressBar = get_node("HealthBar")#ref to hpbar
@onready var stam_bar: TextureProgressBar = get_node("StaminaBar")#ref to stambar

func _ready() -> void:
	max_hp = player.hp
	max_stam = player.stam
	_update_health_bar(100)
	_update_stamina_bar(4)

#animates health
func _update_health_bar(new_value: int) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(health_bar, "value", new_value, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)

func _update_stamina_bar(new_value: int) -> void:
	var tween2: Tween = create_tween()
	tween2.tween_property(stam_bar, "value", new_value, 0.5).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
#updates healthbar
func _on_player_hp_changed(new_hp: int) -> void:
	var new_health: int = int((100 - 0) * float(new_hp) / max_hp) + 0
	_update_health_bar(new_health)
	
#updates stam bar
func _on_player_stam_changed(new_stam: int) -> void:
	var new_stamina: int = int((4 - 0) * float(new_stam) / max_hp) + 0
	_update_stamina_bar(new_stamina)


