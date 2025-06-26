extends Enemy


const DEFAULT_HEALTH = 10000
const SHOT = preload("GunshotShot/GunshotShot.tscn")
const SHOT_SPREAD = PI/2
const SHOT_COUNT = 11
const MAX_SHOT_LENGTH = 180
const SHOT_OFFSET = 16
const WALL_MASK = 0b00000000_00000000_00100000
@export var drop = preload("res://Weapons/ShootyThingamabob/ShootyThingamabob.tscn")


var shooting: bool = false


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = health

func _on_attack_timer_timeout() -> void:
	shooting = true

func move():
	var target_vector := (
		target.global_position - global_position
	)
	
	if not shooting:
		global_rotation = target_vector.angle()
		apply_central_force(
			target_vector.normalized().rotated(PI/3) *
			move_speed
		)
	
	else:
		# Create & rotate shots
		var shots: Array[Area2D] = []
		for shot_index in range(SHOT_COUNT):
			var shot: Area2D = SHOT.instantiate()
			shot.global_position = (
				global_position +
				target_vector.normalized() * SHOT_OFFSET
			)
			shot.rotation = (
				target_vector.angle() +
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
		
		shooting = false
