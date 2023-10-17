extends CharacterBody2D

@export var moveSpeed := 25
@export var maxSpeed := 50

@export var jumpHeight := - 150
@export var maxJump := 1
@export var numJump := 0

@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func _process(delta):
	movePJ()
	jump()
	
func jump():
	if is_on_floor() && numJump != 0:
		numJump = 0

	if numJump < maxJump:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jumpHeight
			numJump += 1
				
func movePJ():
	if Input.is_action_pressed("Right"):
		sprite.flip_h= false
		velocity.x = min(velocity.x+moveSpeed,maxSpeed)
	elif Input.is_action_pressed("Left"):
		sprite.flip_h= true
		velocity.x = max(velocity.x-moveSpeed,-maxSpeed)
	else:
		velocity.x = move_toward(velocity.x, 0, maxSpeed)

	move_and_slide()
