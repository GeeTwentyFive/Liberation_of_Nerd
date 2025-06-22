extends Enemy


const DEFAULT_MOVE_SPEED = 100
const DEFAULT_HEALTH = 400


func _ready() -> void:
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	$Lunger.force_multiplier = 0.5
	super()

func move():
	apply_central_force(
		(target.position - position).normalized().rotated(-PI/6) *
		move_speed
	)
