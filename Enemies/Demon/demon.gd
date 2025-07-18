extends Enemy


const DEFAULT_MOVE_SPEED = 100
const DEFAULT_HEALTH = 400


func _ready() -> void:
	super()
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	max_health = health
	$Lunger.force_multiplier = 0.2

func move():
	apply_central_force(
		(target.position - position).normalized().rotated(-PI/6) *
		move_speed
	)
