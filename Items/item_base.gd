class_name Item
extends Entity


const PICKED_UP_ALPHA = 0.2
const THROW_POSITION_OFFSET_MULTIPLIER = 1.4


var holder: Player = null


func apply_passive():
	pass # Override & implement

func remove_passive():
	pass # Override & implement

func use():
	delete()
	pass # Override & implement


func delete():
	remove_passive()
	queue_free()

func pick_up(player: Player):
	if holder != null: return
	if player.held_item != null: return
	holder = player
	player.held_item = self
	collision_shape.disabled = true
	add_collision_exception_with(holder)
	collision_shape.scale = Vector2(0.5, 0.5)
	sprite.modulate.a = PICKED_UP_ALPHA
	apply_passive()

func drop():
	remove_passive()
	sprite.modulate.a = 1.0
	collision_shape.scale = Vector2.ONE
	remove_collision_exception_with(holder)
	collision_shape.disabled = false
	global_position += (
		holder.linear_velocity.normalized() *
		holder.collision_shape.shape.get_rect().size *
		THROW_POSITION_OFFSET_MULTIPLIER
	)
	apply_central_impulse(holder.linear_velocity)
	holder.held_item = null
	holder = null

func _on_pickup_collider_body_entered(body: Node2D) -> void:
	if body is Player:
		pick_up(body)

func _physics_process(delta: float) -> void:
	if holder:
		sprite.flip_h = false
		global_position = holder.global_position
	else:
		super(delta)

func _input(event: InputEvent) -> void:
	for action in InputMap.get_actions():
		if event.is_action_pressed(action):
			match action:
				"drop_item": if holder: drop()
				"use_item": if holder: use()
