class_name Entity
extends RigidBody2D


@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	sprite.flip_h = linear_velocity.x < 0
