extends Enemy


const DEFAULT_MOVE_SPEED = 100


func _ready() -> void:
	move_speed = DEFAULT_MOVE_SPEED

func move():
	apply_central_force(
		(target.position - position).normalized() * move_speed
	)
