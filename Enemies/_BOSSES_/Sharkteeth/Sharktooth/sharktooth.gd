class_name Sharktooth
extends Enemy


const DEFAULT_HEALTH = 1000
const DEFAULT_LUNGE_FORCE = 50


var lunge_force: int:
	set(x):
		$Lunger.target_lunge_force = x
		lunge_force = x


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = health
	lunge_force = DEFAULT_LUNGE_FORCE

# Override sprite flipping behavior of Entity
func _physics_process(delta: float) -> void:
	global_rotation = (
		target.global_position - global_position
	).angle()
	
	$Lunger.target_position = target.global_position
