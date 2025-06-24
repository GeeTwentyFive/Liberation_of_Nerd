class_name Chicken
extends Enemy


const DEFAULT_HEALTH = 40
const DEFAULT_MOVE_SPEED = 100


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = DEFAULT_HEALTH
	move_speed = DEFAULT_MOVE_SPEED

func move():
	apply_central_force(
		(target.position - position).normalized() * move_speed
	)
