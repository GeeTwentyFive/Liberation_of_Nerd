extends Area2D


const DEFAULT_DAMAGE = 1111
const DEFAULT_SHOT_SPREAD = PI/2
const DEFAULT_SHOT_COUNT = 11
const DEFAULT_MAX_SHOT_LENGTH = 180
const DEFAULT_WALL_MASK = 0b00000000_00000000_00100000


var damage: int = DEFAULT_DAMAGE
var shot_spread: float = DEFAULT_SHOT_SPREAD
var shot_count: int = DEFAULT_SHOT_COUNT
var max_shot_length: int = DEFAULT_MAX_SHOT_LENGTH
var wall_mask: int = DEFAULT_WALL_MASK


func set_damage(damage: int):
	self.damage = damage
	return self

func set_shot_spread(shot_spread: float):
	self.shot_spread = shot_spread
	return self

func set_shot_count(shot_count: int):
	self.shot_count = shot_count
	return self

func set_target_mask(wall_mask: int):
	self.wall_mask = wall_mask
	return self


func shoot(shoot_direction: float):
	rotation = shoot_direction
	
	for shot in get_children():
		var raycast_result = get_world_2d().direct_space_state.intersect_ray(
			PhysicsRayQueryParameters2D.create(
				shot.global_position,
				(
					shot.global_position +
					Vector2.from_angle(shot.rotation) *
					max_shot_length
				),
				wall_mask
			)
		)
		if raycast_result:
			var shot_length: int = (
				(
					raycast_result.position -
					shot.global_position
				).length()
			)
			var shot_shape := RectangleShape2D.new()
			shot_shape.size = Vector2(shot_length, 1)
			shot.shape = shot_shape
			shot.get_child(0).points[1].x = shot_length

func _ready() -> void:
	for dir in range(
		-shot_spread/2,
		shot_spread/2,
		shot_spread/shot_count
	):
		var shot: CollisionShape2D = $Shot.duplicate()
		shot.rotation = dir
		add_child(shot)
