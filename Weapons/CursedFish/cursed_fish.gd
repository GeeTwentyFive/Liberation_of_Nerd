class_name CursedFish
extends Weapon


const DEFAULT_ATTACK_DAMAGE = 41
const PROJECTILE = preload("CursedFishProjectile/CursedFishProjectile.tscn")


var boomerang_returned := true


func _ready() -> void:
	attack_damage = DEFAULT_ATTACK_DAMAGE

func pick_up(player: Player):
	super(player)
	sprite.modulate.a = 0.5
	boomerang_returned = true

func drop():
	sprite.modulate.a = 1.0
	super()

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
			.set_start_pos(global_position + attack_direction)
			.add_collision_exception(holder)
			.add_collision_exception(self)
			.shoot(holder, projectile_vector)
		)
		
		boomerang_returned = false
		
		$AttackCooldown.start()
		super(attack_direction)
