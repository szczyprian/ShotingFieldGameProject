extends CanvasLayer

@export_file("*.tscn") var level1



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(level1)
