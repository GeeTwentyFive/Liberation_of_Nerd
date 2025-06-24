extends Enemy


const DEFAULT_MOVE_SPEED = 100
const DEFAULT_HEALTH = 80


func _ready() -> void:
	super()
	move_speed = DEFAULT_MOVE_SPEED
	health = DEFAULT_HEALTH
	max_health = health
	$Lunger.target_lunge_force = move_speed/2

func move():
	$Lunger.target_position = target.global_position
