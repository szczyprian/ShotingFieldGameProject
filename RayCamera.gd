extends Camera3D

@export var max_bullets:int = 3
var points:int:
	set(points_in):
		points= points_in
		points_label.text= "Points: " + str(points)
		
var bullets:int:
	set(bullets_in):
		bullets = bullets_in
		label.text = "Bullets: " + str(bullets)

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var label: Label = $MarginContainer/Label
@onready var points_label: Label = $MarginContainer/PointsLabel




func  _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	bullets = max_bullets
	points =0;
	
	
func _process(delta: float) -> void:
	var mouse_positon:Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_positon) * 100.0
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding() and bullets>0:
		var collider = ray_cast_3d.get_collider()
		if collider.is_in_group('target'):
				if Input.is_action_just_pressed("shot"):
					print(collider)
					points+=collider.get_parent().deal_damage(10,collider)
				
	
	if Input.is_action_just_pressed("shot") and bullets>0:
		bullets-=1			
		
	if Input.is_action_just_pressed("reload"):
		reload_sequence()
	

		


func reload_sequence() ->void:
	Input.set_default_cursor_shape(Input.CURSOR_WAIT)
	var tween=create_tween()
	tween.tween_interval(3)
	tween.tween_callback(reload)

func reload() ->void:
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)	
	bullets = max_bullets



