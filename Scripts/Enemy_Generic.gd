extends CharacterBody2D
class_name Enemy

#Variable de movimiento horizontal.
@export var move_Speed = 60

#Variable de gravedad.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sensor: Area2D = $"Sensor"

var Main_Character: CollisionObject2D

	#PROCESOS

#Proceso para la gravedad.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func _on_sensor_body_entered(body):
	pass # Replace with function body.
