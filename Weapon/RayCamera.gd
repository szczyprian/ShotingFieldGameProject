extends Camera3D

@export var max_bullets:int = 3
@export var game_time:float = 30.0
@export var muzzleFlashParticle: GPUParticles3D
@export var weapon_mesh:Node3D


var points:int:
	set(points_in):
		points= points_in
		points_label.text= "Points: " + str(points)
		
var bullets:int:
	set(bullets_in):
		bullets = bullets_in
		label.text = "Bullets: " + str(bullets)

var time:float:
	set(time_in):
		time = time_in
		if time >=0.0:
			time_label.text = "Time: " + str(round(time))
		else:
			time_label.text = "Level Ended"
			v_box_container.visible = true
			errned_points_label.text = 'You Get ' + str(points) + ' Points' 

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var label: Label = $MarginContainer/Label
@onready var points_label: Label = $MarginContainer/PointsLabel
@onready var time_label: Label = $MarginContainer/TimeLabel
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
@onready var errned_points_label: Label = $MarginContainer/VBoxContainer/ErrnedPointsLabel
@onready var weapon_position:Vector3 = weapon_mesh.position





func  _ready() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)
	bullets = max_bullets
	points =0;
	time= game_time
	
	
func _process(delta: float) -> void:
	time -= delta
	var mouse_positon:Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_positon) * 100.0
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding() and bullets>0:
		var collider = ray_cast_3d.get_collider()
		if collider.is_in_group('target'):
				if Input.is_action_just_pressed("shot"):
					muzzleFlashParticle.restart()
					print(collider)
					points+=collider.get_parent().deal_damage(10,collider)
					weapon_mesh.translate(Vector3.BACK)	
					
					
	
	
	if Input.is_action_just_pressed("shot") and bullets>0:
		weapon_mesh.translate(Vector3.BACK)
		muzzleFlashParticle.restart()
		bullets-=1			
		
	if Input.is_action_just_pressed("reload"):
		reload_sequence()
	weapon_mesh.position =weapon_mesh.position.lerp(weapon_position,delta * 10.0)
	

		


func reload_sequence() ->void:
	Input.set_default_cursor_shape(Input.CURSOR_WAIT)
	var tween=create_tween()
	tween.tween_interval(3)
	tween.tween_callback(reload)

func reload() ->void:
	Input.set_default_cursor_shape(Input.CURSOR_CROSS)	
	bullets = max_bullets





func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
