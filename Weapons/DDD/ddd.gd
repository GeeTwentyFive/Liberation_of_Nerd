extends Weapon


const BASE_ATTACK_DAMAGE = 1
const PROJECTILE = preload("DDDProjectile/DDDProjectile.tscn")


func _ready() -> void:
	attack_damage = BASE_ATTACK_DAMAGE

func pick_up(player: Player):
	super(player)
	sprite.modulate.a = 0.5

func drop():
	sprite.modulate.a = 1.0
	super()

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
			.set_velocity_damage_multiplier(calculate_attack_damage()/100)
			.set_start_pos(global_position)
			.add_collision_exception(holder)
			.add_collision_exception(self)
			.shoot(projectile_vector)
		)
		
		$AttackCooldown.start()
		super(attack_direction)
