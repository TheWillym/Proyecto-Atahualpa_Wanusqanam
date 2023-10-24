extends Node
class_name Movement

#Variable de movimiento horizontal.
@export var move_Speed_Global: float = 40

#Asignación de variable.
var character = CharacterBody2D

func setup(character2D: CharacterBody2D):
	character = character2D
	
func move(imput_vector: Vector2):
	character.velocity = imput_vector.normalized() * move_Speed_Global
	character.move_and_slide()
	
func stop_movement():
	character.velocity = Vector2.ZERO

