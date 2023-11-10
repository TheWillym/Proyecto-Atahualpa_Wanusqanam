extends Node
class_name Movement

@export var acceleration = 1200.0
@export var friction = 1200.0

var tick = 0

var player : Main_Character

#Variable de gravedad.
var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")

func setup(body):
	player = body

func update(delta):
	
	apply_gravity(delta)
	
func apply_gravity(delta):
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
		player.velocity.y = clampf(player.velocity.y, -1200, 980)
