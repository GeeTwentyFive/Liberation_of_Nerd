extends Enemy


const DEFAULT_MOVE_SPEED = 10
const DEFAULT_HEALTH = 400


func _ready() -> void:
	super()
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	max_health = health

func move():
	apply_central_force(
		(target.position - position).normalized() * move_speed
	)
