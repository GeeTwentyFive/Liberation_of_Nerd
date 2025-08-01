extends Weapon


const DEFAULT_ATTACK_DAMAGE = 21
const PROJECTILE = preload("BottomlessChickenPouchProjectile/BottomlessChickenPouchProjectile.tscn")


func _ready() -> void:
	attack_damage = DEFAULT_ATTACK_DAMAGE

func attack(attack_direction: Vector2):
	if $AttackCooldown.is_stopped():
		var projectile_vector := (
			holder.linear_velocity.project(attack_direction) *
			remap(
				holder.linear_velocity.normalized().dot(attack_direction),
				-1.0,
				1.0,
				0.0,
				1.0
			)
		)
		
		get_parent().add_child(
			PROJECTILE.instantiate()
			.set_damage(calculate_attack_damage())
			.set_start_pos(global_position)
			.add_collision_exception(holder)
			.add_collision_exception(self)
			.shoot(projectile_vector)
		)
		
		$AttackCooldown.start()
		super(attack_direction)
