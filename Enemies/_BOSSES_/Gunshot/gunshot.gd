extends Enemy


const DEFAULT_HEALTH = 10000
const SHOT = preload("GunshotShot/GunshotShot.tscn")
const SHOT_SPREAD = PI
const SHOT_COUNT = 11
const MAX_SHOT_LENGTH = 720
const SHOT_OFFSET = 64
const WALL_MASK = 0b00000000_00000000_00100000
@export var drop = preload("res://Weapons/ShootyThingamabob/ShootyThingamabob.tscn")


var shooting: bool = false
var shot := false


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = health
	# TODO: Set $AttackTimer.wait_time to sum of shot timers * 2

func _on_attack_timer_timeout() -> void:
	shooting = !shooting
	if shooting: shot = false

func die():
	var _drop = drop.instantiate()
	_drop.global_position = global_position
	get_parent().add_child(_drop)
	
	super()

# Override sprite flip behavior
func _physics_process(delta: float) -> void:
	if not target: return
	
	var target_vector := (
		target.global_position - global_position
	)
	
	if not shooting:
		global_rotation = target_vector.angle()
		apply_central_force(
			target_vector.normalized().rotated(PI/3) *
			move_speed
		)
	
	elif shooting and not shot:
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
			
			# TODO: vvv do same for ShootyThingamabobShot
			else: shot.set_length(MAX_SHOT_LENGTH)
		
		shot = true
