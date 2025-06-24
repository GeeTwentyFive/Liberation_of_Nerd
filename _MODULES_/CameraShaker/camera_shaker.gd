extends Timer


var shake_direction := Vector2.RIGHT
var shake_strength := 10.0


var target_camera: Camera2D
var previous_offset: Vector2 = Vector2.ZERO


func set_shake_direction(shake_direction: Vector2):
	self.shake_direction = shake_direction
	return self

func set_shake_strength(shake_strength: float):
	self.shake_strength = shake_strength
	return self


func _ready() -> void:
	for node in get_parent().get_children():
		if node is Camera2D and node.enabled:
			target_camera = node
			previous_offset = node.offset

func _on_timeout() -> void:
	target_camera.offset = previous_offset
	queue_free()

func _process(delta: float) -> void:
	if not target_camera:
		queue_free()
		return
	
	target_camera.offset = (
		shake_direction *
		shake_strength *
		time_left *
		sin(remap(
			time_left,
			wait_time,
			0,
			PI*shake_strength,
			-PI*shake_strength
		))
	)
