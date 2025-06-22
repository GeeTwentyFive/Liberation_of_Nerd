extends Area2D


var heal_multiplier := 0.1


func set_target_collision_mask(mask: int):
	collision_mask = mask
	return self

func set_heal_multiplier(heal_multiplier: int):
	self.heal_multiplier = heal_multiplier
	return self


func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		body.health = min(
			body.health + body.health*heal_multiplier,
			body.max_health
		)

func _process(delta: float) -> void:
	$Sprite2D.modulate.a = remap(
		$LifeTimer.time_left,
		$LifeTimer.wait_time,
		0,
		0.5,
		0
	)

func _on_life_timer_timeout() -> void:
	queue_free()
