extends Enemy


const DEFAULT_HEALTH = 2000
const DEFAULT_MOVE_SPEED = 100
const DROP = preload("res://Weapons/CursedFish/CursedFish.tscn")


func _ready() -> void:
	super()
	health = DEFAULT_HEALTH
	max_health = health
	move_speed = DEFAULT_MOVE_SPEED
	$Lunger.target_lunge_force = move_speed/2

func move():
	apply_central_force(
		(target.position - position).normalized() * move_speed
	)
	$Lunger.target_position = target.global_position

func _on_lunger_timeout() -> void:
	await get_tree().physics_frame
	angular_velocity = linear_velocity.length()

func die():
	var drop = DROP.instantiate()
	drop.global_position = global_position
	get_parent().add_child(drop)
	
	super()
