class_name Player
extends Entity


const DEFAULT_MOVE_SPEED = 200
const CAMERA_SMOOTHING_MULTIPLIER = 0.1
@onready var starting_weapon: Weapon = (
	#preload("res://Weapons/DDD/DDD.tscn").instantiate()
	preload("res://Weapons/ShootyThingamabob/ShootyThingamabob.tscn").instantiate()
)
var attack_damage_multiplier := 1.0


signal hit
signal attacked


@onready var camera = $Camera2D
var move_speed: float
var held_item: Item
var held_weapon: Weapon


func _on_hurt_collider_body_entered(body: Node2D) -> void:
		hit.emit()

func _ready() -> void:
	set_move_speed(DEFAULT_MOVE_SPEED)
	(func():
		get_parent().add_child(starting_weapon)
		starting_weapon.pick_up(self)
	).call_deferred()

func set_move_speed(new_move_speed: float):
	move_speed = new_move_speed
	camera.position_smoothing_speed = (
		move_speed * CAMERA_SMOOTHING_MULTIPLIER
	)

func _physics_process(delta: float) -> void:
	var movement_direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	if movement_direction:
		apply_central_force(movement_direction * move_speed)
		if not $AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()
	super(delta)
