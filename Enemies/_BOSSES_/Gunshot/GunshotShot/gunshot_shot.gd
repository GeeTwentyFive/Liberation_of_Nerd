extends Area2D

# Set collision mask to target


@export var shot_color := Color(0, 0, 0, 1)


func set_length(length: int):
	var new_shape := RectangleShape2D.new()
	new_shape.size = Vector2(length, 1)
	$CollisionShape2D.shape = new_shape
	$CollisionShape2D.position.x = length/2
	$Line2D.points[1].x = length
	return self

func _process(delta: float) -> void:
	if not $LifeTimer.is_stopped():
		$Line2D.modulate.a = remap(
			$LifeTimer.time_left,
			$LifeTimer.wait_time,
			0,
			1.0,
			0.0
		)

func _on_aim_timer_timeout() -> void:
	$Line2D.default_color = shot_color
	(func():
		collision_layer = collision_mask
		await get_tree().physics_frame
		for body in get_overlapping_bodies():
			if body is Player:
				body.hit.emit()
	).call_deferred()
	$LifeTimer.start()

func _on_life_timer_timeout() -> void:
	queue_free()
