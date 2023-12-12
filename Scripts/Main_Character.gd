extends CharacterBody2D
class_name Main_Character

	#VARIABLES PARA EL MOVIMIENTO

#Variable de movimiento horizontal.
@export var move_Speed = 80
#@export var acceleration = 1200.0
#@export var friction = 1200.0
#
#var tick = 0

var colliding_Ladder = false
var going_up = false

var colliding_Jumper = false
var jump_UP = false


#Variables de salto.
@export var jump_Height = - 150
@export var max_Jump = 1
@export var num_Jump = 0

@onready var movement : Movement = $"Movement" as Movement

#Variable del knockback.
#@export var knockback_vector = Vector2.ZERO

#Variables de esquiva. 
@export var move_Dodge = 400
@export var time_Dodge = 0.5
var current_Time_Dodge = 0
@export var duplicate_Time_Dodge = 0.05
var current_Duplicate_Time_Dodge = 0
@export var duplicate_Time_Life = 0.3
var is_dodging = false

#Variable de asignación del sprite.
@onready var sprite = $Sprite2D

	#PROCESOS

func _ready():
	movement.setup(self)

#Proceso para la gravedad.
func _physics_process(delta):
	movement.update(delta)
#Proceso para el salto, aquí se determina la cantidad de saltos desbloqueables.
	if is_on_floor() && !going_up && num_Jump != 0:
		num_Jump = 0
	if num_Jump < max_Jump:
		if Input.is_action_just_pressed("ui_accept"):
#			$AnimationPlayer.play("Jump")
			velocity.y = jump_Height
			num_Jump += 1

#Proceso para el movimiento horizontal, aquí se determina la dirección del movimiento
#y el cambio de dirección del sprite; esta condicionado con el proceso de la esquiva.
	var direction_Move = Input.get_axis("Right", "Left")
	if !is_dodging && $TimerTakeDamage.is_stopped():
		if direction_Move:
#			$AnimationPlayer.play("Walk")
			if direction_Move > 0:
				$Sprite2D.scale.x = -1
				velocity.x = direction_Move - move_Speed
			else:
				$Sprite2D.scale.x = 1
				velocity.x = direction_Move + move_Speed
		else:
#			$AnimationPlayer.play("Idle")
			$AnimationPlayer.speed_scale = 1.0
			velocity.x = move_toward(velocity.x, 0, move_Speed)
	else:
		if is_dodging:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
		else:
#			$AnimationPlayer.play("Idle")
			$AnimationPlayer.speed_scale = 1.0
			velocity.x = move_toward(velocity.x, 0.0, move_Speed)
			
	if colliding_Ladder:
		if Input.is_action_pressed("Up"):
			going_up = true
			velocity.y = -move_Speed
			velocity.x = 0
		elif Input.is_action_pressed("Down"):
			going_up = true
			velocity.y = move_Speed
		elif Input.is_action_pressed("ui_accept"):
			going_up = false
			velocity.y = 2 * -move_Speed
		else:
			if going_up:
				velocity.y = 0

				
	if colliding_Jumper:
		if Input.is_action_pressed("ui_accept"):
			jump_UP = true
			velocity.y = -500
		
#Proceso para la esquiva.
	if is_dodging:
		current_Time_Dodge += delta
		current_Duplicate_Time_Dodge += delta
		if current_Time_Dodge >= time_Dodge:
			current_Duplicate_Time_Dodge = 0.0
			current_Time_Dodge = 0.0
			is_dodging = false
		if current_Duplicate_Time_Dodge >= duplicate_Time_Dodge:
			current_Duplicate_Time_Dodge = 0.0
#			createDuplicate()
	if is_dodging == false && Input.is_action_just_pressed("Dodge") && is_on_floor():
		is_dodging = true
		if $Sprite2D.scale.x == 1:
			velocity.x = move_Dodge
		else:
			velocity.x = -move_Dodge
#		createDuplicate()

#func knockback():
#	if knockback_vector != Vector2.ZERO:
#		velocity = knockback_vector

	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Down") and is_on_floor():
		position.y += 1.5
		

	
func take_damage(iPos: Vector2, iDamageAmount: int):
	if !is_dodging && $TimerTakeDamage.is_stopped():
		$TimerTakeDamage.start(0)
		if (iPos.x < position.x):
			velocity.x = 1100
		else:
			velocity.x = -1100

#func hit_Knockback():
#	if $Ray_right.is_colliding():
#		take_Knockback(Vector2(-200, -200))
#		print("Right")
#	elif $Ray_left.is_colliding():
#		take_Knockback(Vector2(200, -200))
#		print("Left")
#
#func take_Knockback(knockback_force = Vector2.ZERO, duration = 0.25):
#	if knockback_force != Vector2.ZERO:
#		knockback_vector = knockback_force
#
#		var knockback_tween = get_tree().create_tween()
#		knockback_tween.tween_property(self, "knockback_vector", Vector2.ZERO, duration)

#func createDuplicate():
#	var duplicate = $Sprite2D.duplicate(true)
#	duplicate.material = $Sprite2D.material.duplicate(true)
#	duplicate.material.set_shader_parameter("opacity", 0.7)
#	duplicate.material.set_shader_parameter("r", 0.0)
#	duplicate.material.set_shader_parameter("g", 0.0)
#	duplicate.material.set_shader_parameter("b", 0.0)
#	duplicate.material.set_shader_parameter("mix_color", 0.6)
#	duplicate.position.y += position.y
#	if $Sprite2D.scale.x == -1:
#		duplicate.position.x = position.x - duplicate.position.x
#	else:
#		duplicate.position.x += position.x
#	duplicate.z_idex -= 1
#	get_parent().add_child(duplicate)
#	await get_tree().create_timer(duplicate_Time_Life).timeout
#	duplicate.queue_free()
	
func _on_timer_take_damage_timeout():
		$TimerTakeDamage.stop()


func _on_ladder_component_area_exited(area):
	area.get_name()
	if area.is_in_group("Ladder"):
		colliding_Ladder = false
		going_up = false

func _on_ladder_component_area_entered(area):
	area.get_name()
	if area.is_in_group("Ladder"):
		colliding_Ladder = true


func _on_climb_up_component_area_exited(area):
	area.get_name()
	if area.is_in_group("Climb"):
		colliding_Jumper = false
		jump_UP = false

func _on_climb_up_component_area_entered(area):
	area.get_name()
	if area.is_in_group("Climb"):
		colliding_Jumper = true
