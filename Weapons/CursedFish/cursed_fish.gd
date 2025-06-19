class_name CursedFish
extends Weapon


const DEFAULT_ATTACK_DAMAGE = 40
const PROJECTILE = preload("CursedFishProjectile.tscn")


var boomerang_returned: bool = true


func _ready() -> void:
	attack_damage = DEFAULT_ATTACK_DAMAGE

func pick_up(player: Player):
	super(player)
	boomerang_returned = true

func attack(attack_direction: Vector2):
	if not boomerang_returned: return
	if $AttackCooldown.is_stopped():
		var projectile_vector: Vector2 = (
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
			.set_start_pos(
				global_position +
				attack_direction *
				holder.collision_shape.shape.get_rect().size
			)
			.add_collision_exception(holder)
			.add_collision_exception(self)
			.shoot(holder, projectile_vector)
		)
		
		boomerang_returned = false
		
		$AttackCooldown.start()
		super(attack_direction)
