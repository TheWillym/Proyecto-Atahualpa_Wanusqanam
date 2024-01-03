extends Node2D

@onready var player = $Main_Character

func _ready():
	if Global.from_level != null:
		player.position = get_node(Global.from_level + "Pos").get_position()

