extends CharacterBody2D
class_name Enemy

#Variable de movimiento.
@onready var movement: Movement = $"Movement" as Movement

#Variable de sensor.
@onready var sensor: Area2D = $"Sensor"

#Variable de asignación para el sensor.
var Main_Character: CollisionObject2D

#Variable de gravedad.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	#PROCESOS

func _ready():
	movement.setup(self)

func _physics_process(delta):
	
		#Proceso para el sensor.
#	if Main_Character != null:
#		var direction = Main_Character.global_position
#		var distance = global_position.direction_to(Main_Character.global_position)
#		if distance > 100:
#			movement.move(direction)
		
		#Proceso para la gravedad.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#Proceso del sensor.
func _on_sensor_body_entered(body):
	Main_Character = body

func _on_sensor_body_exited(body):
	Main_Character = null
	
