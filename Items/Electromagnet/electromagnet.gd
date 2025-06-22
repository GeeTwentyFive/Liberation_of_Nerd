extends Item


const ENEMY_SLOW_MULTIPLIER = 0.01
const BEAM = preload("ElectromagnetBeam.tscn")
const DEFAULT_BEAM_BASE_DAMAGE = 10.0
const SHAKE = preload("ElectromagnetShake.tscn")


var close_enemies: Array[Enemy] = []


func _on_slow_collider_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.linear_velocity = Vector2.ZERO
		body.move_speed *= ENEMY_SLOW_MULTIPLIER
		close_enemies.append(body)

func _on_slow_collider_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.move_speed /= ENEMY_SLOW_MULTIPLIER
		close_enemies.erase(body)

func use():
	super()
	
	var base_damage: int
	if holder.held_weapon:
		base_damage = holder.held_weapon.attack_damage
	else: base_damage = DEFAULT_BEAM_BASE_DAMAGE
	
	get_parent().add_child(
		BEAM.instantiate()
		.prod_damage_multiplier(holder.attack_damage_multiplier)
		.set_base_damage(base_damage)
		.set_start_pos(global_position)
		.shoot(holder.linear_velocity.angle())
	)
	
	holder.add_child(
		SHAKE.instantiate()
		.set_shake_direction(holder.linear_velocity.normalized())
		.set_shake_strength((
			holder.attack_damage_multiplier *
			base_damage
		))
	)
	
	holder.attacked.emit()
	
	for enemy in close_enemies:
		_on_slow_collider_body_exited(enemy)
	delete()
