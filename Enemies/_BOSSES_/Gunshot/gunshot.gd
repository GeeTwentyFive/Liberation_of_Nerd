extends Enemy


const DEFAULT_HEALTH = 10000
const SHOT = preload("GunshotShot/GunshotShot.tscn")
@export var drop = preload("res://Weapons/ShootyThingamabob/ShootyThingamabob.tscn")


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = health

func move():
	global_rotation = (
		target.global_position - global_position
	).angle()
	
	apply_central_force(
		(target.global_position - global_position).normalized().rotated(PI/3) *
		move_speed
	)
	
	# TODO: Shoot GunshotShot's
