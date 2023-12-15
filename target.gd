extends Node3D

var health:int:
			set(health_in):
				health=health_in
				if health<=0:
					var tween = create_tween()
					tween.tween_interval(0.5)
					tween.tween_callback(queue_free)
					
					

@export var max_health:int = 10
@export var grey_area_points:int = 25
@export var green_area_points:int = 50
@export var red_area_points:int = 100
var delete_delay:float = 2.5

var speed:float = 2.0
var direction:Vector3 = Vector3.RIGHT

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_3d: Label3D = $Label3D
@onready var label_animation: AnimationPlayer = $Label3D/LabelAnimation




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	
	
	var tween = create_tween()
	tween.tween_interval(delete_delay)
	tween.tween_callback(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(direction * delta * speed)
	


func deal_damage(damage:int,collider:CSGBox3D) -> int:
	health-=damage
	animation_player.play("take_shot")	
#	label_animation.play("display_points")
	if collider.name == "GreenArea":
		return green_area_points
	elif collider.name == "GreayArea":
		return grey_area_points
	elif collider.name == "RedArea":
		return red_area_points
	else:
		return 0
	


	







