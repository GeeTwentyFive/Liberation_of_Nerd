extends ColorRect


func _on_flash_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	modulate.a = remap(
		$FlashTimer.time_left,
		$FlashTimer.wait_time,
		0,
		1.0,
		0.0
	)
