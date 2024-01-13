extends CanvasLayer

@export_file("*.tscn") var level1
@export_file("*.tscn") var level2



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(level1)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(level2)
