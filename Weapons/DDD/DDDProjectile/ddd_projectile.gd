extends Entity


var velocity_damage_multiplier := 0.01


func set_velocity_damage_multiplier(velocity_damage_multiplier: float):
	self.velocity_damage_multiplier = velocity_damage_multiplier
	return self

func set_start_pos(start_pos: Vector2):
	global_position = start_pos
	return self

func add_collision_exception(target: Node2D):
	add_collision_exception_with(target)
	return self

func shoot(attack_vector: Vector2):
	apply_central_impulse(attack_vector)
	return self


func _on_life_timer_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	rotation = linear_velocity.angle()

func _process(delta: float) -> void:
	$Sprite2D.modulate.a = remap(
		$LifeTimer.time_left,
		$LifeTimer.wait_time,
		0,
		1.0,
		0.0
	)

# 1000**2 * 0.001 * 10 = 10000
func _on_enemy_collider_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.hit(
			linear_velocity.length()**2 *
			velocity_damage_multiplier/1000
		)
