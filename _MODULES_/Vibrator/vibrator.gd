extends Timer


@export var vibration_strength := 1.0


func _physics_process(delta: float) -> void:
	var parent: Node2D = get_parent()
	var vibration_direction := Vector2.from_angle(
		parent.global_rotation + PI/2
	)
	parent.position = (
		parent.global_position +
		vibration_direction *
		vibration_strength *
		sin(remap(
			time_left,
			wait_time,
			0,
			PI,
			-PI
		))
	)
