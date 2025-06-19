extends Area2D


func set_length(length: int):
	var new_shape := RectangleShape2D.new()
	new_shape.size = Vector2(length, 1)
	$CollisionShape2D.shape = new_shape
	$Line2D.points[1].x = length

func _process(delta: float) -> void:
	$Line2D.modulate.a = remap(
		$LifeTimer.time_left,
		$LifeTimer.wait_time,
		0,
		1.0,
		0.0
	)

func _on_life_timer_timeout() -> void:
	queue_free()
