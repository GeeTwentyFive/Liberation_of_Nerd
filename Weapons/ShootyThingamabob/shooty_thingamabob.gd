extends Weapon


const BASE_ATTACK_DAMAGE = 1111
const SHOT = preload("ShootyThingamabobShot.tscn")
const SHOT_SPREAD = PI/2
const SHOT_COUNT = 11
const MAX_SHOT_LENGTH = 180
const SHOT_OFFSET = 16
const WALL_MASK = 0b00000000_00000000_00100000


func _ready() -> void:
	attack_damage = BASE_ATTACK_DAMAGE

func attack(attack_direction: Vector2):
	if $AttackCooldown.is_stopped():
		# Create & rotate shot
		var shots: Array[Area2D] = []
		for shot_index in range(SHOT_COUNT):
			var shot: Area2D = SHOT.instantiate()
			shot.global_position = (
				global_position +
				attack_direction * SHOT_OFFSET
			)
			shot.rotation = (
				attack_direction.angle() +
				-SHOT_SPREAD/2 + (shot_index * SHOT_SPREAD/SHOT_COUNT)
			)
			get_parent().add_child(shot)
			shots.append(shot)
		
		# Clip shot length to wall (if hit)
		for shot in shots:
			var raycast_result = get_world_2d().direct_space_state.intersect_ray(
				PhysicsRayQueryParameters2D.create(
					shot.global_position,
					(
						shot.global_position +
						Vector2.from_angle(shot.rotation) *
						MAX_SHOT_LENGTH
					),
					WALL_MASK
				)
			)
			if raycast_result:
				shot.set_length(
					(
						raycast_result.position -
						shot.global_position
					).length()
				)
		
		# Damage intersecting enemies
		await get_tree().physics_frame
		for shot in shots:
			for body in shot.get_overlapping_bodies():
				if body is Enemy:
					body.linear_velocity = Vector2.ZERO
					body.hit(
						calculate_attack_damage() /
						SHOT_COUNT
					)
		
		$AttackCooldown.start()
		super(attack_direction)
