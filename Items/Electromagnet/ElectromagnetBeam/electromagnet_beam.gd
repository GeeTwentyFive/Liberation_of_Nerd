extends Area2D


var damage_multiplier := 10.0
var base_damage := 10


func set_damage_multiplier(damage_multiplier: int):
	self.damage_multiplier = damage_multiplier
	return self

func prod_damage_multiplier(damage_multiplier: int):
	self.damage_multiplier *= damage_multiplier
	return self

func set_base_damage(base_damage: int):
	self.base_damage = base_damage
	return self

func set_start_pos(start_pos: Vector2):
	global_position = start_pos
	return self

func shoot(angle: float):
	rotation = angle
	return self


func _ready() -> void:
	# Scale size based on damage
	$Line2D.width = sqrt(base_damage * damage_multiplier)
	$Line2D.points[1].x = (base_damage * damage_multiplier) * exp(1)
	var scaled_shape := RectangleShape2D.new()
	scaled_shape.size = Vector2($Line2D.points[1].x, $Line2D.width)
	$CollisionShape2D.shape = scaled_shape
	$CollisionShape2D.position.x = scaled_shape.size.x / 2
	
	$LifeTimer.start(log(base_damage * damage_multiplier))
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		if body is Enemy:
			body.apply_central_impulse(
			Vector2.from_angle(rotation) *
			base_damage * damage_multiplier
		)

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.hit(
			base_damage * damage_multiplier *
			remap(
				$LifeTimer.time_left,
				$LifeTimer.wait_time,
				0,
				1,
				0
			)
		)

func _on_life_timer_timeout() -> void:
	queue_free()

func _process(delta: float) -> void:
	$Line2D.modulate.a = remap(
		$LifeTimer.time_left,
		$LifeTimer.wait_time,
		0,
		1.0,
		0.0
	)
