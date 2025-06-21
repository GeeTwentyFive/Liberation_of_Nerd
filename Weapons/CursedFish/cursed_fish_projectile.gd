extends Entity


var damage := 41


var holder: Player = null


func set_damage(damage: int):
	self.damage = damage
	return self

func set_start_pos(start_pos: Vector2):
	global_position = start_pos
	return self

func add_collision_exception(target: Node2D):
	add_collision_exception_with(target)
	return self

func shoot(holder: Player, attack_vector: Vector2):
	self.holder = holder
	apply_central_impulse(attack_vector)
	return self


func _ready() -> void:
	await get_tree().physics_frame
	rotation = linear_velocity.angle()
	angular_velocity = linear_velocity.length()

# Override & stop sprite flip behavior
# (for rotation)
func _physics_process(delta: float) -> void:
	apply_central_force(
		holder.global_position - global_position
	)
	
	# If moving toward holder
	if linear_velocity.normalized().dot(
		(holder.global_position - global_position).normalized()
	) > 0:
		$CollisionShape2D.disabled = true

func _on_collider_body_entered(body: Node2D) -> void:
	if body is Enemy: body.hit(damage)
	elif body == holder:
		if holder.held_weapon is CursedFish:
			holder.held_weapon.boomerang_returned = true
		queue_free()
