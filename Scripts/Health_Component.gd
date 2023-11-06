extends Area2D
class_name HealthComponent

signal onDead
signal onDamageTook

@export var max_Health: int = 1
var current_Health: int = 1

func _ready() -> void:
	current_Health = max_Health
	
func take_heal(value: int):
	set_health(value)

func take_damage(damage: int):
	var value = abs(damage)
	set_health(-value)

func set_health(value: int):
	current_Health += value
	current_Health = clamp(current_Health, 0, max_Health)
	
	if current_Health <= 0:
		dead()
		
func dead():
	emit_signal("onDead")
	get_parent().queue_free()
	if get_parent() is Main_Character:
		get_tree().reload_current_scene()
