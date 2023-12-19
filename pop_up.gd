extends Node3D

@onready var label_3d: Label3D = $Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()
	tween.tween_interval(2.0)
	tween.tween_callback(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	translate(Vector3(1,1,0) * delta)
