class_name Item
extends Entity


const PICKED_UP_ALPHA = 0.2
const DROP_OFFSET_MULTIPLIER = 1.4


var holder: Player = null
var used := false


func apply_passive():
	pass # Override & implement

func remove_passive():
	pass # Override & implement

func use():
	used = true
	pass # Override & implement


func delete():
	remove_passive()
	queue_free()

func pick_up(player: Player):
	if holder != null: return
	if player.held_item != null: return
	holder = player
	player.held_item = self
	sprite.modulate.a = PICKED_UP_ALPHA
	(func(): collision_shape.disabled = true).call_deferred()
	apply_passive()

func drop():
	if used: return
	remove_passive()
	var drop_vector := holder.linear_velocity
	var drop_offset := holder.collision_shape.shape.get_rect().size
	(func():
		global_position += (
			drop_vector.normalized() *
			drop_offset *
			DROP_OFFSET_MULTIPLIER
		)
		apply_central_impulse(drop_vector)
		collision_shape.disabled = false
	).call_deferred()
	sprite.modulate.a = 1.0
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
