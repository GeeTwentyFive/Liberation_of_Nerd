extends Timer


var target_position: Vector2
var target_lunge_force := 100.0
var force_multiplier := 1.0


@onready var parent = get_parent()


func _ready() -> void:
	assert(parent is RigidBody2D)


func _on_timeout() -> void:
	if target_position:
		parent.apply_central_impulse(
			(target_position - parent.global_position).normalized() *
			target_lunge_force *
			force_multiplier
		)
	else:
		parent.apply_central_impulse(
			parent.linear_velocity *
			force_multiplier
		)
