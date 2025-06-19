extends Label


func _ready() -> void:
	assert(get_parent() is RigidBody2D)


var max_speed: int = 0
func _physics_process(delta: float) -> void:
	text = str(int(get_parent().linear_velocity.length()))
	#if get_parent().linear_velocity.length() > max_speed:
	#	max_speed = get_parent().linear_velocity.length()
	#text = str(max_speed)
