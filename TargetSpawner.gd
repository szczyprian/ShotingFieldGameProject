extends Area3D

@export var target:PackedScene
@export var target_speed:float = 3.0
@export var target_direction:Vector3 = Vector3.RIGHT
@export var delete_delay:float = 2.5
@export var spawning_time:float = 30.0

@onready var timer: Timer = $Timer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_interval(spawning_time)
	tween.tween_callback(timer.stop)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawning_time >=0.0:
		spawning_time-=delta
#		print(spawning_time)

func spawn_targert() ->void:
	var new_target = target.instantiate()
	new_target.delete_delay = delete_delay
	add_child(new_target)
	new_target.speed = target_speed
	new_target.direction = target_direction
	
