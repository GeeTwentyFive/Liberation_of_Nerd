extends Enemy


const DEFAULT_MOVE_SPEED = 100
const DEFAULT_HEALTH = 200


func _ready() -> void:
	super()
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	max_health = health

func move():
	apply_central_force(
		(target.position - position).normalized().rotated(PI/4) * move_speed
	)
