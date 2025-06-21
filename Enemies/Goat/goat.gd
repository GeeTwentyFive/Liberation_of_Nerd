extends Enemy


const DEFAULT_MOVE_SPEED = 100
const DEFAULT_HEALTH = 80


func _ready() -> void:
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH

func move():
	if linear_velocity.length() > 0.1: return
	apply_central_impulse(
		(target.position - position).normalized() * move_speed/2
	)
