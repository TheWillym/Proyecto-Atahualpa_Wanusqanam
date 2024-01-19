extends Sprite2D

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer

func _ready():
	$AnimationPlayer.play("Idle")
