extends Area2D

func _on_body_entered(_body):
	Global.from_level = get_parent().name
	get_tree().change_scene_to_file("res://_GAME/2_Scenes/" + self.name + ".tscn")
